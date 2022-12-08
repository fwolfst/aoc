#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/8

input = ARGF.readlines.map &:strip

puts "---"

def score trees, x, y
  return 0 if (x * y) == 0 || x == (trees.first.size - 1) || y == (trees.size - 1)

  height = trees[y][x]
  lefts =  trees[y][...x].reverse.take_while {_1 < height}.count
  rights = trees[y][(x+1)..].take_while {_1 < height}.count

  lefts = [lefts + 1, x].min
  rights = [rights + 1, trees[y].count - x - 1].min

  col = trees.map{_1[x]}
  ups = col[0...y].reverse.take_while {_1 < height}.count
  downs =  col[y+1..].take_while {_1 < height}.count

  ups = [ups + 1, y].min
  downs = [downs + 1, col.count - y - 1].min

  rights * lefts * ups * downs
end

trees = input.map do |line|
  line.chars.map &:to_i
end

scores = []

trees.each_with_index do |row, y|
  row.each_with_index do |height, x| 
    scores << score(trees, x, y)
  end
end

p scores.max

