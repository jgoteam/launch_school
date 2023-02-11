class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { "Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.key?(rank) ? VALUES[rank] : rank
  end

  def <=>(other)
    value <=> other.value
  end
end

# Further Exploration
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


