require_relative 'deck.rb'

class PlayingBoard
  def initialize(players, parameters = {})
    @card_num = parameters[:card_num] || 2
    card_class = parameters[:card_class] || PlayingCard
    deck_class = parameters[:deck_class] || Deck
    @deck = deck_class.new(card_class)
    @players = {}
    players.each { |player| @players[player] = @deck.retrieve_cards(2) }
  end

  def pass_cards(player, number)
    players[player] ||= []
    cards = deck.retrieve_cards(number)
    cards.each { |card| players[player].push(card) }
  end

  def get_cards(player)
    players[player]
  end

  def status
    players.map { |player, cards| "#{player} cards: #{cards.each(&:to_s).join(" ")}"}.join("\n")
  end

  private

  attr_reader :card_num, :deck, :players
end
