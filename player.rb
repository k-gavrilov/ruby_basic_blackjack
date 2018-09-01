require_relative 'playing_card.rb'

class Player
  attr_reader :cards, :passes_num

  def initialize(name)
    @name = name
    @cards = []
    @passes_num = 0
  end

  def take_cards(cards)
    cards.each { |card| self.cards.push(card) }
  end

  def score
    cards.reduce(0) do |sum, card|
      sum + card_value(card, sum)
    end
  end

  def cards_num
    cards.size
  end

  def add_pass
    self.passes_num += 1
  end

  def reset
    self.cards = []
    self.passes_num = 0
  end

  def card_info
    cards.each(&:to_s).join(" ")
  end

  def can_open?
    true
  end

  def <=>(other)
    return 0 if score == other.score
    if score > 21 && other.score > 21
      score < other.score ? 1 : -1
    elsif score <= 21 && other.score <= 21
      score > other.score ? 1 : -1
    else
      score < other.score ? 1 : -1
    end
  end

  def to_s
    name
  end

  protected

  attr_reader :name
  attr_writer :passes_num, :cards

  def card_value(card, sum)
    case card.dignity
    when 2..10
      card.dignity
    when 11..13
      10
    when 14
      if sum < 21 && 21 - sum >= 11
        11
      else
        1
      end
    end
  end
end
