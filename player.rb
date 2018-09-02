require_relative 'playing_card.rb'

class Player
  attr_reader :cards, :passes_num

  def initialize(name)
    @name = name
    @cards = []
    @passes_num = 0
    @cards_opened = false
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
    self.cards_opened = false
  end

  def card_info
    cards.each(&:to_s).join(" ")
  end

  def can_open?
    true
  end

  def cards_opened?
    cards_opened
  end

  def open_cards
    self.cards_opened = true
  end

  def <=>(other)
    return 0 if score == other.score
    if score > 21 && other.score > 21
      compare_over_scores(score, other.score)
    elsif score <= 21 && other.score <= 21
      compare_below_scores(score, other.score)
    else
      compare_polar_scores(score, other.score)
    end
  end

  def to_s
    name
  end

  protected

  attr_reader :name
  attr_writer :passes_num, :cards
  attr_accessor :cards_opened

  def compare_over_scores(first_score, second_score)
    first_score < second_score ? 1 : -1
  end

  def compare_below_scores(first_score, second_score)
    first_score > second_score ? 1 : -1
  end

  def compare_polar_scores(first_score, second_score)
    first_score < second_score ? 1 : -1
  end

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
