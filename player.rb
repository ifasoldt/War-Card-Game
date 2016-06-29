require './deck'

class Player
  attr_reader :name, :playing_deck, :capture_deck, :played_card
  def initialize(name)
    @name = name
    @playing_deck = Deck.new
  end

  def play_card
    @played_card = @playing_deck.shift
  end
end

computer = Player.new("Computer")
puts computer.name
