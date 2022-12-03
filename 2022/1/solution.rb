# frozen_string_literal: true

# Parse the input file
class ParseFile
  attr_reader :elves

  def initialize(path)
    @lines = []
    File.open(path).each do |line|
      @lines << line
    end
    @elves = parse_elves(@lines)
  end

  private

  def parse_elves(lines)
    current_elf = 1
    elves = {}
    lines.each do |line|
      current_elf += 1 if line == "\n"
      if !elves.key?(current_elf)
        elves[current_elf] = line.to_i
      else
        elves[current_elf] += line.to_i
      end
    end
    elves
  end
end

# Solution
class Solution
  attr_reader :first_elf, :top_three_elves

  def initialize(elves)
    @elves = elves
    @first_elf = find_elf_calories {}[1]
    @top_three_elves = find_top_three_elves_with_most_calories
  end

  private

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
