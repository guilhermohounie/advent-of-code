# frozen_string_literal: true

# Parse the stacks
class ParseStacks
  attr_reader :stacks

  def initialize(path)
    file = File.open(path, 'r')
    @stacks = get_stacks(file)
  end

  private

  def get_stacks(file)
    stacks = []
    while (line = file.gets)
      break if line.strip.empty?

      line.chars.each_with_index do |char, index|
        next unless char =~ /[A-Z]/

        pos = if index == 1
                1
              else
                (index + 3) / 4
              end

        stacks[pos - 1] = [] unless stacks[pos - 1]
        stacks[pos - 1] << char
      end
    end
    stacks.map(&:reverse)
  end
end

# Parse the procedures
class ParseProcedures
  attr_reader :procedures

  def initialize(path)
    @procedures = get_procedures(path)
  end

  private

  def get_procedures(path)
    File.readlines(path).select { |line| line.start_with?('move') }.map { |line| line.split(' ') }.map do |arr|
      {
        crates: arr[1].to_i,
        from: arr[3].to_i,
        to: arr[5].to_i
      }
    end
  end
end

# Solution Class
class Crates
  attr_reader :top_crates, :top_crates_two

  def initialize(stack_one, stack_two, procedures)
    @procedures = procedures
    @top_crates = rearrangement(stack_one, procedures)
    @top_crates_two = rearrangement_9001(stack_two, procedures)
  end

  private

  def rearrangement(stacks, procedures)
    procedures.each do |procedure|
      from = procedure[:from] - 1
      to = procedure[:to] - 1
      crates = procedure[:crates]
      crates.times do
        last = stacks[from][-1]
        stacks[to] << last
        stacks[from].delete_at(-1)
      end
    end
    stacks.map { |stack| stack[-1] }.join
  end

  def rearrangement_9001(stacks, procedures)
    procedures.each do |procedure|
      from = procedure[:from] - 1
      to = procedure[:to] - 1
      crates = procedure[:crates]
      stacks[to] = stacks[to] + stacks[from][-crates..-1]
      stacks[from] = stacks[from][0..-crates - 1]
    end
    stacks.map { |stack| stack[-1] }.join
  end
end
