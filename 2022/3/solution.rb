# frozen_string_literal: true

require 'set'

ITEMS = [*'a'..'z', *'A'..'Z'].freeze

# Parse the rucksacks
class ParseRucksacks
  attr_reader :rucksacks

  def initialize(path)
    @rucksacks = File.readlines(path).map do |line|
      first, second = line.gsub(/\n/, '').partition(/.{#{line.length / 2}}/)[1, 2]
      {
        first_compartment: first,
        second_compartment: second
      }
    end
  end
end

# Rucksacks
class Rucksacks
  attr_reader :sum, :badges_sum

  def initialize(rucksacks)
    @sum = solve(rucksacks)
    @badges_sum = solve_badges(rucksacks.each_slice(3).to_a)
  end

  private

  # Concat the two compartments of a rucksack
  def rucksack_combine_compartments(rucksack)
    rucksack.values.join('')
  end

  # Find the item that is shared between n rucksacks
  def rucksacks_intersections(*rucksacks)
    rucksacks.map { |rucksack| Set.new(rucksack.split('')) }.reduce(:intersection).to_a[0]
  end

  # Get the shared item between the two compartments of a rucksack
  def shared_item_between_compartments(rucksack)
    Set.new(rucksack[:first_compartment].split('')).intersection(rucksack[:second_compartment].split('')).to_a[0]
  end

  # Find the item that is shared between n rucksacks
  def shared_item_between_groups(rucksack_group)
    elf1 = rucksack_combine_compartments(rucksack_group[0])
    elf2 = rucksack_combine_compartments(rucksack_group[1])
    elf3 = rucksack_combine_compartments(rucksack_group[2])
    rucksacks_intersections(elf1, elf2, elf3)
  end

  def solve(rucksacks)
    rucksacks.reduce(0) do |sum, rucksack|
      sum + ITEMS.index(shared_item_between_compartments(rucksack)) + 1
    end
  end

  def solve_badges(rucksacks_groups)
    rucksacks_groups.reduce(0) do |sum, rucksack_group|
      sum + ITEMS.index(shared_item_between_groups(rucksack_group)) + 1
    end
  end
end
