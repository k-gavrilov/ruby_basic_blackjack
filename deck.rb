class Deck
  def initialize(card_class)
    @card_set = []
    card_class.each_unique_card { |dignity, suit| @card_set << card_class.new(dignity, suit) }
    @card_set.freeze
    @card_buffer = @card_set.shuffle
  end

  def reset
    self.card_buffer = card_set.shuffle
    self
  end

  def retrieve_cards(number)
    return unless number <= card_buffer.size
    card_buffer.pop(number)
  end

  private

  attr_reader :card_set
  attr_accessor :card_buffer
end
