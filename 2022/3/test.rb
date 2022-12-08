# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    rucksacks = ParseRucksacks.new(File.join(__dir__, 'input.txt')).rucksacks

    solution = Rucksacks.new(rucksacks)

    assert_equal 7793, solution.sum
    assert_equal 2499, solution.badges_sum
  end
end
