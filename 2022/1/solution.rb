# frozen_string_literal: true

# Parse the input file
class ParseFile
  attr_reader :lines

  def initialize(path)
    @lines = []
    File.open(path).each do |line|
      @lines << line
    end
  end
end

# Solution
class Solution
  attr_reader :elves

  def initialize(lines)
    @lines = lines
    @elves = {}
  end

  def solve
    parse_elves
    puts find_elf_with_most_calories.to_s
    puts find_top_three_elves_with_most_calories
  end

  private

  def parse_elves
    current_elf = 1
    @lines.each do |line|
      current_elf += 1 if line == "\n"
      if !@elves.key?(current_elf)
        @elves[current_elf] = line.to_i
      else
        @elves[current_elf] += line.to_i
      end
    end
  end

  def find_elf_with_most_calories
    @elves.max_by { |_, calories| calories }
  end

  def find_calories_after(&block)
    # find the elf with the most calories that is not in the block
    @elves.reject(&block).max_by { |_, calories| calories }
  end

  def find_top_three_elves_with_most_calories
    first = find_elf_with_most_calories
    second = find_calories_after { |elf, _| elf == first[0] }
    third = find_calories_after { |elf, _| elf == first[0] || elf == second[0] }
    first[1] + second[1] + third[1]
  end
end

file = ParseFile.new('input.txt')
solution = Solution.new(file.lines)

solution.solve
