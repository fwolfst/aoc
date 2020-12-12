#!/usr/bin/env ruby

# Puzzle 24: https://adventofcode.com/2020/day/12#part2
# Felix Wolfsteller

DEBUG = true

def dputs string
  puts string if DEBUG
end

EAST  = 'E'
SOUTH = 'S'
WEST  = 'W'
NORTH = 'N'

DIRECTIONS = {
  EAST   => [ 1, 0],
  SOUTH  => [ 0,-1],
  WEST   => [-1, 0],
  NORTH  => [ 0, 1]
}

ORIENTATIONS = [EAST, SOUTH, WEST, NORTH]

x = 0
y = 0
position = [x,y]
orientation = EAST
waypoint = [10,1]

ARGF.readlines.each do |line|
  mod,amount = line[0], line[1..-1].to_i
  if mod == 'L'
    degrees = amount
    case degrees / 90
    when 0
    when 1
      waypoint = [-waypoint[1],  waypoint[0]]
    when 2
      waypoint = [-waypoint[0], -waypoint[1]]
    when 3
      waypoint = [ waypoint[1], -waypoint[0]]
    end
  elsif mod == 'R'
    degrees = amount
    degrees = amount
    case degrees / 90
    when 0
    when 1
      waypoint = [ waypoint[1], -waypoint[0]]
    when 2
      waypoint = [-waypoint[0], -waypoint[1]]
    when 3
      waypoint = [-waypoint[1],  waypoint[0]]
    end
  elsif mod == 'F'
    mod = waypoint
    position = [position[0] + mod[0] * amount, position[1] + mod[1] * amount]
  else
    mod = DIRECTIONS[mod]
    waypoint = [waypoint[0] + mod[0] * amount, waypoint[1] + mod[1] * amount]
  end
  dputs line
  dputs "waypoint = #{waypoint}, position = #{position}"
end

puts position
puts position.map(&:abs).sum

exit 0
