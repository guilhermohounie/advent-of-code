# frozen_string_literal: true

require_relative '../solution'

def test_solution
  file = ParseFile.new('../input.txt')
  solution = Solution.new(file.stacks, file.procedures)

  # raise 'Error getting top crates' unless solution.top_crates == 'TPGVQPFDH'
  # p solution.top_crates_9001
  # p solution.top_crates_9001

  puts 'Test passed'
end

test_solution
