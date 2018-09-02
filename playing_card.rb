class PlayingCard
  MIN_DIGNITY = 2
  MAX_DIGNITY = 14
  MIN_SUIT = 0
  MAX_SUIT = 3
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
    validate!
  end

  def self.each_unique_card
    MIN_DIGNITY.upto(MAX_DIGNITY) do |dignity|
      MIN_SUIT.upto(MAX_SUIT) { |suit| yield(dignity, suit) }
    end
  end

  def to_s
    dignity_str = dignity.between?(2, 10) ? dignity.to_s : CARD_NAMES[dignity]
    suit_str = CARD_SUITS[suit]
    "#{dignity_str}#{suit_str}"
  end

  def validate!
    raise "No Dignity Error" if dignity.nil?
    raise "No Suit Error" if suit.nil?
    raise "Dignity Range Error" unless dignity.between?(MIN_DIGNITY, MAX_DIGNITY)
    raise "Suit Range Error" unless suit.between?(MIN_SUIT, MAX_SUIT)
    return true
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end
end
