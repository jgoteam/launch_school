class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    new_deck
  end

  def draw
    new_deck if deck.empty?
    self.deck.shift
  end

  private

  attr_accessor :deck

  def new_deck
    self.deck =
     (RANKS * 4).zip(SUITS * 13).each_with_object([]) do |card, deck|
        deck << Card.new(card[0], card[1])
      end.shuffle
  end
end

class Card
  attr_reader :rank, :suit
  include Comparable

  VALUES = { "Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }
  SUIT_ORDER = { "Diamonds" => 0.0, "Clubs" => 0.1, "Hearts" => 0.2, "Spades" => 0.3 }
  private_constant :VALUES, :SUIT_ORDER

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    rank_value = VALUES.key?(rank) ? VALUES[rank] : rank
    suit_value = SUIT_ORDER[suit]
    rank_value + suit_value
  end

  def <=>(other)
    value <=> other.value
  end
end
