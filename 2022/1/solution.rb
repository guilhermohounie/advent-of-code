# frozen_string_literal: true

# Parse the input file
class ParseFile
  attr_reader :elves

  def initialize(path)
    @lines = []
    @elves = {}
    File.open(path).each do |line|
      @lines << line
    end
    parse_elves
  end

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
end

# Solution
class Solution
  attr_reader :first_elf_calories, :top_three_calories

  def initialize(elves)
    @elves = elves
  end

  # Find an elf with the most calories ignoring the ones passed in the block condition
  def find_elf_calories(&block)
    @elves.reject(&block).max_by { |_, calories| calories }
  end

  def find_top_three_elves_with_most_calories
    first = find_elf_calories {}
    second = find_elf_calories { |elf, _| elf == first[0] }
    third = find_elf_calories { |elf, _| elf == first[0] || elf == second[0] }
    first[1] + second[1] + third[1]
  end
end
