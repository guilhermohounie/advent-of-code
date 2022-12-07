# frozen_string_literal: true

OPPONENT_HAND_SYMBOLS = {
  A: 'Rock',
  B: 'Paper',
  C: 'Scissors'
}.freeze

MY_HAND_SYMBOLS = {
  X: 'Rock',
  Y: 'Paper',
  Z: 'Scissors'
}.freeze

HAND_SCORE_SYMBOL = {
  Rock: 1,
  Paper: 2,
  Scissors: 3
}.freeze

# Parse the turns
class ParseTurns
  attr_reader :turns

  def initialize(path)
    @turns = File.readlines(path).map do |line|
      hands = line.gsub(/\s+/, '')
      {
        opponent_hand: hands[0], my_hand: hands[1]
      }
    end
  end
end

#  Calculate the scores
class CalculateTurnsScores
  attr_reader :score, :score_part_two

  def initialize(turns)
    @score = calculate_score(turns)
    @score_part_two = calculate_score_part_two(turns)
  end

  private

  def turn_result(turn)
    my_hand = MY_HAND_SYMBOLS[turn[:my_hand].to_sym]
    opponent_hand = OPPONENT_HAND_SYMBOLS[turn[:opponent_hand].to_sym]

    turn_score = if opponent_hand == 'Rock' && my_hand == 'Paper' ||
                    opponent_hand == 'Paper' && my_hand == 'Scissors' ||
                    opponent_hand == 'Scissors' && my_hand == 'Rock'
                   6
                 elsif opponent_hand == my_hand
                   3
                 else
                   0
                 end

    hand_score = HAND_SCORE_SYMBOL[my_hand.to_sym]

    hand_score + turn_score
  end

  def turn_result_part_two(turn)
    opponent_hand = OPPONENT_HAND_SYMBOLS[turn[:opponent_hand].to_sym]
    my_hand_symbol = turn[:my_hand].to_sym
    turn_score = 0
    hand_score = 0

    case my_hand_symbol
    when :Y
      turn_score = 3
      hand_score = HAND_SCORE_SYMBOL[opponent_hand.to_sym]
    when :Z
      turn_score = 6
      case opponent_hand
      when 'Rock' then hand_score = HAND_SCORE_SYMBOL[:Paper]
      when 'Paper' then hand_score = HAND_SCORE_SYMBOL[:Scissors]
      when 'Scissors' then hand_score = HAND_SCORE_SYMBOL[:Rock]
      end
    when :X
      turn_score = 0
      case opponent_hand
      when 'Rock' then hand_score = HAND_SCORE_SYMBOL[:Scissors]
      when 'Paper' then hand_score = HAND_SCORE_SYMBOL[:Rock]
      when 'Scissors' then hand_score = HAND_SCORE_SYMBOL[:Paper]
      end
    end

    turn_score + hand_score
  end

  def calculate_score(turns)
    turns.reduce(0) do |score, turn|
      score + turn_result(turn)
    end
  end

  def calculate_score_part_two(turns)
    turns.reduce(0) do |score, turn|
      score + turn_result_part_two(turn)
    end
  end
end
