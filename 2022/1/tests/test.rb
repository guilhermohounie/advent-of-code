# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('../input.txt')

  solution = Solution.new(file.elves)

  raise 'Error getting top elf' unless solution.first_elf == 74_394
  raise 'Error getting top 3 elves' unless solution.top_three_elves == 212_836

  puts 'Test passed!'
end

test_solution
