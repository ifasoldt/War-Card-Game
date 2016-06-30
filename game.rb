require './player'
require './deck'
require './card'
require 'erb'

class Game
  attr_accessor :round_counter, :war_counter, :war_box, :player1, :player2, :winner, :total_record, :rematch
  def initialize
    self.round_counter = 0
    self.war_counter = 0
    self.player1 = Player.new("Sean")
    self.player2 = Player.new("Isaiah")
    self.war_box = []
    self.winner = ""
    self.total_record = []
  end


  def play
    self.rematch = true
    while rematch
      setup
      until player1.playing_deck == [] || player2.playing_deck == []
      clash
      end
      end_and_record
      rematch?
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

  def setup
    player1.playing_deck = Deck.new.deck
    player2.playing_deck = Deck.new.deck
    war_box.clear
    player1.capture_deck.clear
    player2.capture_deck.clear
    player2.shuffle
    player1.shuffle
  end

  def clash
      draw
      if player1.played_card.value > player2.played_card.value
        player1_wins
      elsif player2.played_card.value > player1.played_card.value
        player2_wins
      else
        war_time
      end
      combine_decks
  end

  def draw
    player1.play_card
    player2.play_card
    combine_decks
  end

  def player1_wins
    player1.capture_deck.insert(0, player2.played_card, player1.played_card)
    player1.capture_deck += war_box
    war_box.clear
    @round_counter += 1
  end

  def player2_wins
    player2.capture_deck.insert(0, player2.played_card, player1.played_card)
    player2.capture_deck += war_box
    war_box.clear
    @round_counter += 1
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

  def end_and_record
    end_game
    record_results
  end

  def end_game
    if player1.capture_deck.length == 0 && player1.playing_deck.length == 0
      isaiah_wins
    elsif player2.capture_deck.length == 0 && player2.playing_deck.length == 0
      sean_wins
    else
      nobody_wins
    end
  end

  def isaiah_wins
    puts "Isaiah won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
    @winner = "Isaiah"
  end

  def sean_wins
    puts "Sean won this game after #{self.round_counter} rounds and survived #{self.war_counter} WARs. Would you like a rematch? (Y/N)"
    @winner = "Sean"
  end

  def nobody_wins
    puts "After #{self.round_counter} rounds and #{self.war_counter} WARs, it's a tie!  Would you like a rematch? (Y/N)"
    @winner = "Tie!"
  end
  
  def rematch?
    response = gets.chomp&.downcase[0]
    if response == "y"
      self.rematch = true
    else
      self.rematch = false
    end
    rematch
  end

  def record_results
    self.total_record << { rounds: @round_counter, wars: @war_counter, winner: @winner }
    @round_counter = 0
    @war_counter = 0
    @winner = ''
  end

  def results_to_file
    new_file = File.open('results.html', 'w+')
    new_file << ERB.new(File.read('results.erb')).result(binding)
    new_file.close
  end
end

bob = Game.new
bob.play
bob.results_to_file
