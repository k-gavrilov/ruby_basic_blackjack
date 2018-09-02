require_relative 'text_interface.rb'
require_relative 'player.rb'
require_relative 'playing_board.rb'
require_relative 'playing_bank.rb'
require_relative 'blackjack_controller.rb'
require_relative 'dealer.rb'

class BlackJackGame
  def initialize
    @controller = BlackJackController.new
    @player = Player.new(@controller.ask_user_name)
    @dealer = Dealer.new
    @board = PlayingBoard.new([@player, @dealer])
  end

  def play_game
    prepare_game
    loop do
      play_round
      return unless controller.play_again?
      bankrupt = bank.bankrupt
      if bankrupt
        return unless controller.reset_bank?(bankrupt)
        self.bank = PlayingBank.new([player, dealer])
      end
    end
  end

  protected

  attr_reader :player, :dealer, :board, :controller
  attr_accessor :bank

  private

  def play_round
    prepare_round
    loop do
      current_player = board.next_player
      controller.make_player_choice(current_player, board)
      break if board.limit_reached? || current_player.cards_opened?
    end
    process_round_results
  end

  def process_round_results
    winner = board.winner
    bank.win_bank(winner)
    controller.show_results(board.status, board.scores_info, winner, bank.status)
  end

  def prepare_game
    players = [@player, @dealer]
    @bank = PlayingBank.new(players)
  end

  def prepare_round
    board.reset
    bank.make_bets
  end
end
