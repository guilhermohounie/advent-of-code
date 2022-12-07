# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    turns = ParseTurns.new('./input.txt').turns

    solution = CalculateTurnsScores.new(turns)

    assert_equal 11_841, solution.score
    assert_equal 13_022, solution.score_part_two
  end
end
