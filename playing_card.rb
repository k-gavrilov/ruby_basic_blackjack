class PlayingCard
  attr_reader :suit, :dignity

  def initialize(dignity, suit)
    @dignity = dignity
    @suit = suit
  end

  def to_s
    "#{dignity}#{suit}"
  end
end
