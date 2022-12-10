# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    input = ParseFileTree.new('input.txt').input
    filetree = FileTree.new(input)
    assert_equal 1_642_503, filetree.cap_size
    assert_equal 6_999_588, filetree.free
  end
end
