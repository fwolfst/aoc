#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2019/day/1
# Felix Wolfsteller

lines = ARGF.readlines

BOARD_SIZE = 4048

#  ^
#  y
#  y
#  y
#  0xxx >
#  [x][y]
map = {}
X = 0
Y = 1

Point = Struct.new(:x, :y) do
  def manhattan_from_center
    return x.abs + y.abs
  end
end

wires = lines.map do |line|
  wire_locations = []
  cursor = Point.new(0, 0)
  movements = line.split(",")

  movements.each do |movement|
    mod = case movement[0]
    when 'U'
      [ 0, +1]
    when 'D'
      [ 0, -1]
    when 'R'
      [+1,  0]
    when 'L'
      [-1,  0]
    end

    movement[1..-1].to_i.times do
      cursor.x +=  mod[X]
      cursor.y +=  mod[Y]

      wire_locations << cursor.dup
    end
  end

  wire_locations
end

closest = (wires[0] & wires[1]).min{|p| p.manhattan_from_center} 
puts "min: #{closest} + #{closest.manhattan_from_center}"

exit 0
