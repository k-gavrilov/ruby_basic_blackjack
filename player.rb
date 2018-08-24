require_relative 'playing_card.rb'
require_relative 'text_interface.rb'

class Player
  include TextInterface

  def initialize(name)
    @name = name
  end

  def make_decision(cards, options_str_arr, parameters)
    message = parameters[:message] || "Choose what to do:"
    score = parameters[:score]
    score_message = "Your score is #{score}\n"
    cards_message = "Your cards are: " + cards.map(&:to_s).join(", ") + "\n"
    resulting_message = cards_message + score_message + message
    choose_option(resulting_message, options_str_arr)
  end
end
