# frozen_string_literal: true

# Parse the elves
class ElvesParser
  attr_reader :elves

  def initialize(path)
    @elves = parse_elves(File.readlines(path))
  end

  private

  def parse_elves(lines)
    current_elf = 1
    elves = {}
    lines.each do |line|
      current_elf += 1 if line == "\n"
      elves[current_elf] = (elves[current_elf] || 0) + line.to_i
    end
    elves
  end
end

# Elves calories
class ElvesCalories
  attr_reader :first_elf, :top_three_elves

  def initialize(elves)
    @elves = elves
    @first_elf = find_elf_calories {}[1]
    @top_three_elves = find_top_three_elves_with_most_calories
  end

  private

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
