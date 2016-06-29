require './card'

class Deck
  attr_accessor :deck

  def initialize
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    @deck = []
    suits.each do |suit|
    (2..14).collect { |value| @deck << Card.new(value, suit) }
    end
  end

end
