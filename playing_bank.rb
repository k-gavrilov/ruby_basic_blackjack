class PlayingBank
  def initialize(players, parameters = {})
    @bank = 0
    starting_bank = parameters[:starting_bank] || 100
    @default_bet = parameters[:default_bet] || 10
    @players = {}
    players.each { |player| @players[player] = starting_bank }
  end

  def make_bets
    return unless players.values.reduce(true) { |result, bank| result && bank >= default_bet }
    return unless bank.zero?
    take_bets
  end

  def win_bank(player)
    if player.nil?
      players.transform_values! { |v| v + default_bet }
      self.bank = 0
      return
    end
    return unless players[player]
    players[player] += bank
    self.bank = 0
    true
  end

  def bankrupt
    player_arr = players.find { |_player, bank| bank < default_bet }
    player_arr ? player_arr[0] : nil
  end

  def status
    "Bank status:\n" + players.map { |player, bank| "#{player}: #{bank}" }.join("\n")
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
