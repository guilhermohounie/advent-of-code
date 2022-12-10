# frozen_string_literal: true

# Parse the filetree
class ParseFileTree
  attr_reader :input

  def initialize(path)
    @input = File.read(File.join(__dir__, path)).lines.map { |l| l.scan(/\S+/) }
  end
end

# File tree
class FileTree
  attr_accessor :dir, :cap_size, :free

  def initialize(input)
    @dir = parse(input)
    @cap_size = @dir.map { |d| d[:size] }.filter { |s| s <= 100_000 }.sum
    @free = free_space(@dir)
  end

  private

  def add_size(dir, size, base)
    return if base.nil?

    dir[base][:size] += size
    add_size(dir, size, dir[base][:parent])
  end

  def free_space(dir)
    space = 30_000_000 - (70_000_000 - dir[0][:size])
    @free = dir.map { |d| d[:size] }.filter { |s| s >= space }.min
  end

  def parse(input)
    dir = []
    current_dir = nil
    i = 0

    loop do
      break if i >= input.length

      case input[i][0]
      when '$'
        if input[i][1] == 'cd'
          new_dir = input[i][2]
          case new_dir
          when '..'
            current_dir = dir[current_dir][:parent]
          else
            dir.push({ name: new_dir, parent: current_dir, children: [], size: 0 })
            dir[current_dir][:children].push(dir.length - 1) unless current_dir.nil?
            current_dir = dir.length - 1
          end
        end
      else
        dir[current_dir][:children].push(input[i][1])
        add_size(dir, input[i][0].to_i, current_dir)
      end
      i += 1
    end
    dir
  end
end
