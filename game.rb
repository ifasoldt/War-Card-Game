require './player'
require './deck'
require './card'

class Game
  attr_accessor :round_counter, :war_counter, :war_box, :player1, :player2,
  def initialize
    self.round_counter = 0
    self.war_counter = 0
    self.player1 = Player.new("Sean")
    self.player2 = Player.new("Isaiah")
  end

  def play
    puts "All right, lets play war!"
    isaiah.shuffle
    sean.shuffle
    until sean.playing_deck == [] || isaiah.playing_deck == []
      sean.play_card
      isaiah.play_card
      if sean.played_card.value > isaiah.played_card.value
        sean.capture_deck << sean.played_card && isaiah.played_card && war_box
        puts "Sean's #{sean.played_card.name} of #{sean.played_card.suit} beat Isaiah's #{isaiah.played_card.name} of #{isaiah.played_card.suit}"
        @round_counter += 1
      elsif isaiah.played_card.value > sean.played_card.value
        isaiah.capture_deck << isaiah.played_card && isaiah.played_card && war_box
        @round_counter += 1
        puts "Isaiah's #{isaiah.played_card.name} of #{isaiah.played_card.suit} beat Sean's #{sean.played_card.name} of #{sean.played_card.suit}"
      else
        war_time
        puts "War!!"
      end
      combine_decks
    end
    if sean.capture_deck.length > isaiah.capture_deck.length
      puts "Sean won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
    elsif isaiah.capture_deck.length > sean.capture_deck.length
      puts "Isaiah won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
    else
      puts "it's a tie! Would you like a rematch"
    end
    ask_for_rematch
  end

  def ask_for_rematch
    resp = gets.chomp&.downcase[0]
    if resp == "y"
      Game.new.play
    else
      puts "Thanks for playing."
    end
  end
  def combine_decks
    if sean.playing_deck == []
      sean.playing_deck = sean.capture_deck.shuffle!
      sean.capture_deck = []
    end
    if isaiah.playing_deck == []
      isaiah.playing_deck = isaiah.capture_deck.shuffle!
      isaiah.capture_deck = []
    end
  end

  def war_time
    war_box << isaiah.played_card && sean.played_card
    4.times.do |x|
    combine_decks
    sean.play_card
    isaiah.play_card
    war_box << isaiah.played_card && sean.played_card
  end
end

Game.new.play
