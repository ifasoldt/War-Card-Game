require './deck'

class Player
  attr_accessor :name, :playing_deck, :capture_deck, :played_card
  def initialize(name)
    @name = name
    @playing_deck = Deck.new.deck
    @capture_deck = []
  end

  def play_card
    @played_card = @playing_deck.shift
  end

  def shuffle
    playing_deck.shuffle!
  end
end

5.times do |x|
  puts "hello"
end
