#!/usr/bin/env ruby

# Puzzle 18: https://adventofcode.com/2021/day/9#part2
# Felix Wolfsteller

require 'set'

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines(chomp: true)

SIZE = [lines[0].length, lines.count]

Coordinate = Struct.new(:x, :y) do
  def above
    Coordinate.new(x, y - 1)
  end
  def below
    Coordinate.new(x, y + 1)
  end
  def left_of
    Coordinate.new(x - 1, y)
  end
  def right_of
    Coordinate.new(x + 1, y)
  end
end

class PointInMap
  attr_accessor :coordinate, :height
  def initialize(coordinate, height)
    @coordinate = coordinate
    @height = height
  end

  def low_point?(world)
    right = world[coordinate.right_of]
    left  = world[coordinate.left_of]
    below = world[coordinate.below]
    above = world[coordinate.above]

    (right.nil? || right.height > height) &&
    (left.nil?  || left.height > height) &&
    (above.nil?  || above.height > height) &&
    (below.nil?  || below.height > height)
  end

  def neighbours(world)
    right = world[coordinate.right_of]
    left  = world[coordinate.left_of]
    below = world[coordinate.below]
    above = world[coordinate.above]

    [right,left,below,above].compact.compact
  end

  def to_s
    "[#{coordinate.x},#{coordinate.y}]: #{height}"
  end
end

world = {}

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    coordinate = Coordinate.new(x,y)
    world[coordinate] = PointInMap.new(coordinate, char.to_i)
  end
end

low_points = world.values.select{|p| p.low_point?(world)}

basins = low_points.map do |basin|
  basin_set = Set.new
  basin_set << basin
  expanding = true

  while expanding
    points_to_add = Set.new
    basin_start_size = basin_set.size
    basin_set.each do |basin_point|
      new_points = basin_point.neighbours(world).select{|n| n.height != 9}
      points_to_add.merge new_points
    end
    basin_set.merge points_to_add
    expanding = (basin_start_size != basin_set.size)
  end

  basin_set
end

puts basins.map(&:size).sort.last(3).reduce(&:*)

exit 0
