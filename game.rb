require './player'
require './deck'
require './card'

class Game
  attr_accessor :round_counter, :war_counter, :war_box, :player1, :player2
  def initialize
    self.round_counter = 0
    self.war_counter = 0
    self.player1 = Player.new("Sean")
    self.player2 = Player.new("Isaiah")
    self.war_box = []
    self.total_counter = []
  end

    def play
      puts "All right, lets play war!"
      player2.shuffle
      player1.shuffle
      until player1.playing_deck == [] || player2.playing_deck == []
        player1.play_card
        player2.play_card
        combine_decks
        if player1.played_card.value > player2.played_card.value
          player1.capture_deck.insert(0, player2.played_card, player1.played_card)
          player1.capture_deck += war_box
          war_box.clear
          puts "Sean's #{player1.played_card.name} of #{player1.played_card.suit} beat Isaiah's #{player2.played_card.name} of #{player2.played_card.suit}"
          puts player1.capture_deck.length
          @round_counter += 1
        elsif player2.played_card.value > player1.played_card.value
          player2.capture_deck.insert(0, player2.played_card, player1.played_card)
          player2.capture_deck += war_box
          war_box.clear
          puts "Isaiah's #{player2.played_card.name} of #{player2.played_card.suit} beat Sean's #{player1.played_card.name} of #{player1.played_card.suit}"
          puts player2.capture_deck.length
          @round_counter += 1
        else
          war_time
          puts "War!!"
        end
        combine_decks
      end
      if player1.capture_deck.length == 0 && player1.playing_deck.length == 0
        puts "Isaiah won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
        puts player2.capture_deck.length + player2.playing_deck.length
      elsif player2.capture_deck.length == 0 && player2.playing_deck.length == 0
        puts "Sean won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
          puts player1.capture_deck.length + player1.playing_deck.length
      else
        puts "it's a tie! Would you like a rematch"
      end
      ask_for_rematch

      # self.total_counter << { rounds: @rounds}
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
    if player1.playing_deck == []
      player1.playing_deck = player1.capture_deck.shuffle!
      player1.capture_deck = []
    end
    if player2.playing_deck == []
      player2.playing_deck = player2.capture_deck.shuffle!
      player2.capture_deck = []
    end
  end

  def war_time
    war_box.insert(-1, player2.played_card, player1.played_card)
    4.times do |x|
      combine_decks
      player1.play_card
      player2.play_card
      war_box.insert(-1, player2.played_card, player1.played_card)
    end
      @war_counter += 1
  end
end

Game.new.play
