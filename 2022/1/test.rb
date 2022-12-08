# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    elves = ElvesParser.new(File.join(__dir__, 'input.txt')).elves

    solution = ElvesCalories.new(elves)

    assert_equal 74_394, solution.first_elf
    assert_equal 212_836, solution.top_three_elves
  end
end
