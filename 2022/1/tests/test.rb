# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('input.txt')

  solution = Solution.new(file.elves)

  first = solution.find_elf_calories[1]
  top_three = solution.find_top_three_elves_with_most_calories

  raise 'Error getting top elf' unless first == 6200
  raise 'Error getting top 3 elves' unless top_three == 15_200

  puts 'Test passed!'
end

test_solution
