require './card'

class Deck
  attr_accessor :playing_deck,

  def initialize
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    @playing_deck = []
    suits.each do |suit|
    (2..14).collect { |value| @playing_deck << Card.new(value, suit) }
    end
  end

  def draw
    @playing_deck.shift
  end


end
deck = Deck.new
