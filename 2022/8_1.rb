#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/8

input = ARGF.readlines.map &:strip

puts "---"

def visible? trees, x, y
  return true if (x * y) == 0 || x == (trees.first.size - 1) || y == (trees.size - 1)

  height = trees[y][x]
  return true if trees[y][0...x].all? {_1 < height} # left
  return true if trees[y][x+1..].all? {_1 < height} # right

  col = trees.map{_1[x]}
  return true if col[0...y].all? {_1 < height} # up
  return true if col[y+1..].all? {_1 < height} # down

  false
end

trees = input.map do |line|
  line.chars.map &:to_i
end

count = 0

trees.each_with_index do |row, y|
  row.each_with_index do |height, x| 
    count +=1 if visible?(trees, x, y)
  end
end

p count
