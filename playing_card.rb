class PlayingCard
  MIN_DIGNITY = 2
  MAX_DIGNITY = 14
  JACK = 11
  QUEEN = 12
  KING = 13
  ACE = 14
  DIAMONDS = 0
  HEARTS = 1
  SPADES = 2
  CLUBS = 3
  CARD_NAMES = {JACK => "Jack", QUEEN => "Queen", KING => "King", ACE => "Ace"}.freeze
  CARD_SUITS = {DIAMONDS => "<>", HEARTS => "<3", SPADES => "^", CLUBS => "+"}.freeze

  attr_reader :suit, :dignity

  def initialize(dignity, suit)
    @dignity = dignity
    @suit = suit
    # Add validations here
  end

  def to_s
    dignity_str = dignity.between?(2, 10) ? dignity.to_s : CARD_NAMES[dignity]
    suit_str = CARD_SUITS[suit]
    "#{dignity_str}#{suit_str}"
  end
end
