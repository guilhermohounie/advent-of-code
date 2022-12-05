# frozen_string_literal: true

require_relative '../solution'

def test_solution
  game = ParseFile.new('../input.txt')

  solution = Solution.new(game.turns)

  raise 'Error calculating score' unless solution.score == 11_841
  raise 'Error calculating score' unless solution.score_part_two == 13_022

  puts 'Test passed!'
end

test_solution
