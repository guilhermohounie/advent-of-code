# frozen_string_literal: true

# Parse the tree grid
class ParseTreeGrid
  attr_reader :grid

  def initialize(path)
    @grid = File.readlines(File.join(__dir__, path)).map { |l| l.scan(/\d/).map(&:to_i) }
  end
end

# Tree grid
class TreeGrid
  attr_reader :visible_trees, :score

  def initialize(grid)
    @grid = grid
    @visible_trees = count_visible_trees(grid)
    @score = count_score(grid)
  end

  def to_s
    @grid.each do |row|
      p row
    end
  end

  private

  def count_visible_trees(grid)
    count = 0
    (1..grid.length - 2).each do |r|
      (1..grid[0].length - 2).each do |c|
        count += 1 if tree_visible?(grid, r, c)
      end
    end
    count + (grid.length + grid[0].length - 2) * 2
  end

  def count_score(grid)
    score = 0
    (1..grid.length - 2).each do |r|
      (1..grid[0].length - 2).each do |c|
        score = score_sum(grid, r, c, score)
      end
    end
    score
  end

  def tree_visible?(grid, r, c)
    visible  = grid[r][0..c - 1].all? { |t| t < grid[r][c] }
    visible |= grid[r][c + 1..].all? { |t| t < grid[r][c] }
    visible |= grid[0..r - 1].all? { |t| t[c] < grid[r][c] }
    visible | grid[r + 1..].all? { |t| t[c] < grid[r][c] }
  end

  def score_sum(grid, r, c, score)
    visible = [grid[r][0..c - 1].reverse.map { |t| t < grid[r][c] }]
    visible.push(grid[r][c + 1..].map { |t| t < grid[r][c] })
    visible.push(grid[0..r - 1].reverse.map { |t| t[c] < grid[r][c] })
    visible.push(grid[r + 1..].map { |t| t[c] < grid[r][c] })
    visible = visible.map { |v| (v.find_index(&:!) || v.length - 1) + 1 }
    [score, visible.inject(:*)].max
  end
end
