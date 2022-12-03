# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('input.txt')

  solution = Solution.new(file.rucksacks)

  raise 'Error in score sum' unless solution.sum == 124
  raise 'Error in badges sum' unless solution.badges_sum == 60

  puts 'Test passed!'
end

test_solution
