# frozen_string_literal: true

ITEMS = [*'a'..'z', *'A'..'Z'].freeze

# Parse the input file
class ParseFile
  attr_reader :rucksacks

  def initialize(path)
    @rucksacks = []
    File.open(path).each do |line|
      first, second = line.gsub(/\n/, '').partition(/.{#{line.length / 2}}/)[1, 2]
      @rucksacks << {
        first_compartment: first,
        second_compartment: second
      }
    end
  end
end

# Solution
class Solution
  attr_reader :sum, :badges_sum

  def initialize(rucksacks)
    @rucksacks = rucksacks
    @rucksacks_groups = @rucksacks.each_slice(3).to_a
    @sum = solve(@rucksacks)
    @badges_sum = solve_badges(@rucksacks_groups)
  end

  private

  def shared_item_between_compartments(rucksack)
    shared_item = nil
    rucksack[:first_compartment].each_char do |char|
      shared_item = char if rucksack[:second_compartment].include?(char)
    end
    shared_item
  end

  def shared_item_between_groups(rucksack_group)
    shared_item = nil
    first_compartment = rucksack_group[0][:first_compartment].concat(rucksack_group[0][:second_compartment])
    second_compartment = rucksack_group[1][:first_compartment].concat(rucksack_group[1][:second_compartment])
    third_compartment = rucksack_group[2][:first_compartment].concat(rucksack_group[2][:second_compartment])
    first_compartment.each_char do |char|
      shared_item = char if second_compartment.include?(char) && third_compartment.include?(char)
    end
    shared_item
  end

  def solve(rucksacks)
    sum = 0
    rucksacks.each do |rucksack|
      sum += ITEMS.index(shared_item_between_compartments(rucksack)) + 1
    end
    sum
  end

  def solve_badges(rucksacks_groups)
    sum = 0
    rucksacks_groups.each do |rucksack_group|
      sum += ITEMS.index(shared_item_between_groups(rucksack_group)) + 1
    end
    sum
  end
end
