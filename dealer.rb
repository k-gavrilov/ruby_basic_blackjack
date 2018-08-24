class Dealer
  TAKE_CARD = 0
  PASS_TURN = 1
  TAKING_THRESHOLD = 16
  def make_decision(score)
    score > TAKING_THRESHOLD ? PASS_TURN : TAKE_CARD
  end

  def to_s
    "Dealer"
  end
end
