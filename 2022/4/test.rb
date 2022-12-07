# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    sections = ParseSections.new('./input.txt').sections

    solution = ElvesSections.new(sections)

    assert_equal 567, solution.subsets
    assert_equal 907, solution.overlaps
  end
end
