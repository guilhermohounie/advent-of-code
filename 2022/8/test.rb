# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    grid = ParseTreeGrid.new('input.txt').grid
    tree_grid = TreeGrid.new(grid)
    assert_equal 1825, tree_grid.visible_trees
    assert_equal 235_200, tree_grid.score
  end
end
