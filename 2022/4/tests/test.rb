# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('../input.txt')

  solution = Solution.new(file.sections)

  raise 'Error in count sum' unless solution.subsets == 567
  raise 'Error in count sum' unless solution.overlaps == 907

  puts 'Test passed!'
end

test_solution
