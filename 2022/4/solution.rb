# frozen_string_literal: true

require 'set'

# Parse the  sections
class ParseSections
  attr_reader :sections

  def initialize(path)
    @sections = File.readlines(path).map do |line|
      section = line.split(',')
      {
        first_elf: section[0],
        second_elf: section[1]
      }
    end
  end
end

# Elves sections
class ElvesSections
  attr_reader :subsets, :overlaps

  def initialize(sections)
    @subsets = sum_of_subsets(sections)
    @overlaps = sum_of_overlaps(sections)
  end

  private

  def transform_section_into_set(range)
    start, finish = range.split('-').map(&:to_i)
    Set.new(start..finish)
  end

  def sum_of_subsets(sections)
    sections.reduce(0) do |count, section|
      first_elf = transform_section_into_set(section[:first_elf])
      second_elf = transform_section_into_set(section[:second_elf])
      if first_elf.subset?(second_elf) || second_elf.subset?(first_elf)
        count + 1
      else
        count
      end
    end
  end

  def sum_of_overlaps(sections)
    sections.reduce(0) do |count, section|
      first_elf = transform_section_into_set(section[:first_elf])
      second_elf = transform_section_into_set(section[:second_elf])
      if (first_elf & second_elf).to_a.empty?
        count
      else
        count + 1
      end
    end
  end
end
