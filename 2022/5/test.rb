# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    stack_one = ParseStacks.new('./input.txt').stacks
    stack_two = ParseStacks.new('./input.txt').stacks
    procedures = ParseProcedures.new('./input.txt').procedures

    solution = Crates.new(stack_one, stack_two, procedures)

    assert_equal 'TPGVQPFDH', solution.top_crates
    assert_equal 'DMRDFRHHH', solution.top_crates_two
  end
end
