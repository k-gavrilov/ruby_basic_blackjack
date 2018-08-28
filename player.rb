require_relative 'playing_card.rb'
require_relative 'text_interface.rb'

class Player
  include TextInterface
  ENTER_NAME = "Enter your name".freeze
  NON_EMPTY = /\S+/

  attr_reader :name

  def initialize
    @name = enter_value(ENTER_NAME, NON_EMPTY)
  end

  def make_decision(cards, options_str_arr, parameters = {})
    message = parameters[:message] || "Choose what to do:"
    score = parameters[:score]
    score_message = score ? "Your score is #{score}\n" : ""
    cards_message = "Your cards are: " + cards.map(&:to_s).join(", ") + "\n"
    resulting_message = cards_message + score_message + message
    choose_option(resulting_message, options_str_arr)
  end

  def to_s
    name
  end
end
