class Deck
  SUITS = %w[♦️ ♣️ ♠️ ♥️].freeze
  DIGNITIES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize
    @card_buffer = create_deck
  end

  def reset
    self.card_buffer = create_deck
  end

  def retrieve_cards(number)
    return unless number <= card_buffer.size
    card_buffer.pop(number)
  end

  def create_deck
    DIGNITIES.each_with_object([]) do |dignity, arr|
      SUITS.each { |suit| arr << PlayingCard.new(dignity, suit) }
    end.shuffle!
  end

  protected

  attr_accessor :card_buffer
end
