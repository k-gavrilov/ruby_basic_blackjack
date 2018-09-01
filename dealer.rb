require_relative 'playing_card.rb'
require_relative 'player.rb'

class Dealer < Player
  attr_reader :cards, :passes_num

  def initialize
    super("Dealer")
  end

  def can_open?
    false
  end
end
