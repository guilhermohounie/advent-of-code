# frozen_string_literal: true

# Parse the input file
class ParseFile
  attr_reader :stacks, :procedures

  def initialize(path)
    file = File.open(path, 'r')
    @stacks = get_stacks(file)
    @procedures = get_procedures(file)
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

# Solution Class
class Solution
  attr_reader :top_crates, :top_crates_two

  def initialize(stacks, procedures)
    @stacks = stacks
    @procedures = procedures
    # @top_crates = rearrangement(stacks, procedures)
    @top_crates_two = rearrangement_9001(stacks, procedures)
  end

  private

  def rearrangement(stacks, procedures)
    s = stacks.dup
    procedures.each do |procedure|
      from = procedure[:from] - 1
      to = procedure[:to] - 1
      crates = procedure[:crates]
      crates.times do
        s[to] << s[from].pop
      end
    end
    s.map { |stack| stack[-1] }.join
  end

  def rearrangement_9001(stacks, procedures)
    s = stacks.dup
    procedures.each do |procedure|
      from = procedure[:from] - 1
      to = procedure[:to] - 1
      crates = procedure[:crates]
      # instead of moving the crates one by one we can move the whole stack at once here.
      puts "Moving #{crates} crates from stack #{from + 1} to stack #{to + 1}"
      s[to] = s[to] + s[from][-crates..-1]
      s[from] = s[from][0..-crates - 1]
    end
    p s.map { |stack| stack[-1] }.join
  end
end
