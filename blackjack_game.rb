require_relative 'text_interface.rb'
require_relative 'player.rb'
require_relative 'playing_board.rb'
require_relative 'playing_bank.rb'

class BlackJackGame
  include TextInterface
  PASS_TURN = 0
  OPEN_CARDS = 1
  TAKE_CARD = 2
  TAKING_THRESHOLD = 16
  PLAYER_FULL_OPTIONS = ["0: Pass turn", "1: Open cards", "2: Take card"].freeze
  PLAYER_SHORT_OPTIONS = ["0: Pass turn", "1: Open cards"].freeze
  RESUME_OPTIONS = ["0: Play again", "1: Stop game"].freeze
  RESET_BANK = ["0: Reset bank", "1: Quit"].freeze
  PLAY_AGAIN = 0
  STOP_GAME = 1
  RESET = 0
  QUIT = 1
  def initialize
    @player = Player.new
    @dealer = :Dealer
  end

  def play_game
    prepare_game
    loop do
      play_round
      return unless play_again?
      bankrupt = bank.bankrupt
      if bankrupt
        show_message("#{bankrupt} has no money to make new bet")
        return unless reset_bank?
        self.bank = PlayingBank.new([player, dealer])
      end
    end
  end

  protected

  attr_reader :player, :dealer, :board
  attr_accessor :bank

  private

  def reset_bank?
    choice = choose_option("Would you like to reset bank?", RESET_BANK)
    choice == RESET
  end

  def play_round
    prepare_round
    loop do
      options = board.get_cards(player).length < 3 ? PLAYER_FULL_OPTIONS : PLAYER_SHORT_OPTIONS
      choice = player.make_decision(board.get_cards(player), options)
      case choice
      when TAKE_CARD then board.pass_cards(player, 1)
      when OPEN_CARDS then break
      end
      board.pass_cards(dealer, 1) if dealer_takes?(count_score(dealer))
      break if card_limit_reached?
    end
    process_round_results
  end

  def play_again?
    choice = choose_option("Play again?", RESUME_OPTIONS)
    choice == PLAY_AGAIN
  end

  def process_round_results
    show_message(board.status)
    show_message(scores_info)
    winner = find_winner || "Nobody"
    bank.win_bank(winner)
    show_message("#{winner} wins")
    show_message(bank.status)
  end

  def scores_info
    "Scores:\n#{player}: #{count_score(player)}\n#{dealer}: #{count_score(dealer)}"
  end

  def find_winner
    player_score = count_score(player)
    dealer_score = count_score(dealer)
    if player_score == dealer_score
      nil
    elsif player_score == 21
      player
    elsif dealer_score == 21
      dealer
    elsif player_score > 21 && dealer_score > 21
      player_score < dealer_score ? player : dealer
    elsif player_score < 21 && dealer_score < 21
      player_score > dealer_score ? player : dealer
    else
      player_score < 21 ? player : dealer
    end
  end

  def count_score(person)
    cards = board.get_cards(person)
    cards.reduce(0) do |sum, card|
      sum + card_value(card, sum)
    end
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

  def card_limit_reached?
    [player, dealer].reduce(true) { |result, person| board.get_cards(person).length >= 3 && result }
  end

  def dealer_takes?(score)
    return if board.get_cards(dealer).length >= 3
    score <= TAKING_THRESHOLD
  end

  def prepare_game
    players = [@player, @dealer]
    @bank = PlayingBank.new(players)
  end

  def prepare_round
    players = [@player, @dealer]
    @board = PlayingBoard.new(players)
    bank.make_bets
  end
end
