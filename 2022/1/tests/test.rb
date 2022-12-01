# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('input.txt')

  solution = Solution.new(file.lines)

  solution.solve

  raise 'Error getting top elf' unless solution.first_elf_calories == 6200
  raise 'Error getting top 3 elves' unless solution.top_three_calories == 15_200

  puts 'Test passed!'
end

test_solution
