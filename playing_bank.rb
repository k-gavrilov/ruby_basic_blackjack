class PlayingBank
  def initialize(players, parameters = {})
    @bank = 0
    starting_bank = parameters[:starting_bank] || 100
    @default_bet = parameters[:default_bet] || 10
    @players = {}
    players.each { |player| @players[player] = starting_bank }
  end

  def make_bets
    return unless players.values.reduce { |result, bank| result && bank >= default_bet }
    take_bets
  end

  def win_bank(player)
    return unless players[player]
    players[player] += bank
    self.bank = 0
    true
  end

  def show_info
    players.map { |player, bank| "#{player}: #{bank}" }.join("\n").concat("\nCurrent bank: #{bank}")
  end

  protected

  attr_accessor :bank, :default_bet

  private

  attr_reader :players

  def take_bets
    players.transform_values! { |v| v - default_bet }
    self.bank += default_bet * players.size
    true
  end
end
