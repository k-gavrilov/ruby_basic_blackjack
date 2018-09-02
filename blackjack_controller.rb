require_relative 'text_interface.rb'
require_relative 'option_method_mapper.rb'

class BlackJackController
  ENTER_NAME = "Please, enter your name:".freeze
  CHOOSE_ACTION = "Choose what to do:".freeze
  NOT_BLANK = /\S+/
  TAKING_THRESHOLD = 16
  TAKE_CARD = "Take card".freeze
  TAKE_CARD_LMBD = ->(player, board) { board.pass_cards(player, 1) }
  PASS_TURN = "Pass turn".freeze
  PASS_TURN_LMBD = ->(player, _board) { player.add_pass }
  OPEN_CARDS = "Open cards".freeze
  OPEN_CARDS_LMBD = ->(player, _board) { player.open_cards }
  PLAY_AGAIN_OPTIONS = ["0: Play again", "1: Exit game"].freeze
  RESET_BANK_OPTIONS = ["0: Reset bank", "1: Exit game"].freeze
  PLAY_AGAIN = 0
  RESET_BANK = 0

  attr_reader :interface

  def initialize
    @interface = TextInterface.new
  end

  def ask_user_name
    interface.enter_value(ENTER_NAME, NOT_BLANK)
  end

  def make_player_choice(player, board)
    if player.can_open?
      mapper = generate_mapper(player)
      message = "\nPlayer #{player}:\n#{player.card_info}\n" + CHOOSE_ACTION
      choice = interface.choose_option(message, mapper.options_str_arr)
      mapper.get_action(choice).call(player, board)
    else
      make_dealer_decision(player, board)
    end
  end

  def play_again?
    choice = interface.choose_option(CHOOSE_ACTION, PLAY_AGAIN_OPTIONS)
    choice == PLAY_AGAIN
  end

  def reset_bank?(looser)
    message = "#{looser} has no money to make new bet\n" + CHOOSE_ACTION
    choice = interface.choose_option(message, RESET_BANK_OPTIONS)
    choice == RESET_BANK
  end

  def show_results(board_status, scores_info, winner, bank_status)
    winner ||= "Nobody"
    interface.show_message("ROUND FINISHED")
    interface.show_message(board_status)
    interface.show_message(scores_info)
    interface.show_message("#{winner} has won")
    interface.show_message(bank_status)
  end

  protected

  def generate_mapper(player)
    mapper = OptionMethodMapper.new
    mapper.add_option(OPEN_CARDS_LMBD, OPEN_CARDS)
    mapper.add_option(PASS_TURN_LMBD, PASS_TURN) if player.passes_num.zero?
    mapper.add_option(TAKE_CARD_LMBD, TAKE_CARD) if player.cards_num < 3
    mapper
  end

  def make_dealer_decision(dealer, board)
    if dealer.cards_num >= 3
      dealer.add_pass
    elsif dealer.score < TAKING_THRESHOLD
      board.pass_cards(dealer, 1)
    end
  end
end
