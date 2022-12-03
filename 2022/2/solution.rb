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

# Parse the input file
class ParseFile
  attr_reader :turns

  def initialize(path)
    @turns = []
    File.open(path).each do |fileline|
      line = fileline.gsub(/\s+/, '')
      opponent_hand = line[0]
      my_hand = line[1]
      @turns << {
        opponent_hand: opponent_hand, my_hand: my_hand
      }
    end
  end
end

#  Solution class
class Solution
  attr_reader :score, :score_part_two

  def initialize(turns)
    @turns = turns
    @score = calculate_score(@turns)
    @score_part_two = calculate_score_part_two(@turns)
  end

  private

  def turn_result(turn)
    hand_score = HAND_SCORE_SYMBOL[MY_HAND_SYMBOLS[turn[:my_hand].to_sym].to_sym]

    opponent_hand = OPPONENT_HAND_SYMBOLS[turn[:opponent_hand].to_sym]
    my_hand = MY_HAND_SYMBOLS[turn[:my_hand].to_sym]

    if opponent_hand == 'Rock' && my_hand == 'Paper' || opponent_hand == 'Paper' && my_hand == 'Scissors' || opponent_hand == 'Scissors' && my_hand == 'Rock'
      turn_score = 6
    elsif opponent_hand == my_hand
      turn_score = 3
    else
      turn_score = 0
    end

    hand_score + turn_score
  end

  def turn_result_part_two(turn)
    opponent_hand = OPPONENT_HAND_SYMBOLS[turn[:opponent_hand].to_sym]
    my_hand_symbol = turn[:my_hand].to_sym
    turn_score = 0
    hand_score = 0

    if my_hand_symbol == :Y
      turn_score = 3
      hand_score = HAND_SCORE_SYMBOL[opponent_hand.to_sym]
    end
    if my_hand_symbol == :Z
      turn_score = 6
      case opponent_hand
      when 'Rock' then hand_score = HAND_SCORE_SYMBOL[:Paper]
      when 'Paper' then hand_score = HAND_SCORE_SYMBOL[:Scissors]
      when 'Scissors' then hand_score = HAND_SCORE_SYMBOL[:Rock]
      end
    end
    if my_hand_symbol == :X
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
    score = 0
    turns.each do |turn|
      score += turn_result(turn)
    end
    score
  end

  def calculate_score_part_two(turns)
    score_part_two = 0
    turns.each do |turn|
      score_part_two += turn_result_part_two(turn)
    end
    score_part_two
  end
end
