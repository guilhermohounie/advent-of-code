# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('input.txt')

  solution = Solution.new(file.elves)

  raise 'Error getting top elf' unless solution.first_elf == 6200
  raise 'Error getting top 3 elves' unless solution.top_three_elves == 15_200

  puts 'Test passed!'
end

test_solution
