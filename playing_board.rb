require_relative 'deck.rb'

class PlayingBoard
  def initialize(players, parameters = {})
    @card_num = parameters[:card_num] || 2
    card_class = parameters[:card_class] || PlayingCard
    deck_class = parameters[:deck_class] || Deck
    @deck = deck_class.new(card_class)
    @players = players
    players.each { |player| pass_cards(player, @card_num) }
  end

  def pass_cards(player, number)
    return unless players.include?(player)
    player.take_cards(deck.retrieve_cards(number))
  end

  def limit_reached?
    players.reduce(true) { |result, player| result && player.cards_num >= 3 }
  end

  def status
    players.map { |player| "#{player}'s cards: #{player.card_info}" }.join("\n")
  end

  def winner
    return nil if players.uniq(&:score).size <= 1
    players.max
  end

  def reset
    deck.reset
    players.each(&:reset)
    players.each { |player| pass_cards(player, card_num) }
  end

  def scores_info
    players.map { |player| "#{player}'s score - #{player.score} points" }.join("\n")
  end

  protected

  attr_reader :card_num, :deck, :players
end
