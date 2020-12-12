#!/usr/bin/env ruby

# Puzzle 23: https://adventofcode.com/2020/day/12
# Felix Wolfsteller

DEBUG = false

def dputs string
  puts string if DEBUG
end

EAST  = 'E'
SOUTH = 'S'
WEST  = 'W'
NORTH = 'N'

DIRECTIONS = {
  EAST   => [ 1, 0],
  SOUTH  => [ 0, 1],
  WEST   => [-1, 0],
  NORTH  => [ 0,-1]
}

ORIENTATIONS = [EAST, SOUTH, WEST, NORTH]

x = 0
y = 0
position = [x,y]
orientation = EAST

ARGF.readlines.each do |line|
  mod,amount = line[0], line[1..-1].to_i
  if mod == 'L'
    degrees = amount
    orientation = ORIENTATIONS[
      (ORIENTATIONS.index(orientation) - degrees / 90) % 4
    ]
  elsif mod == 'R'
    degrees = amount
    orientation = ORIENTATIONS[
      (ORIENTATIONS.index(orientation) + degrees / 90) % 4
    ]
  elsif mod == 'F'
    mod = DIRECTIONS[orientation]
    position = [position[0] + mod[0] * amount, position[1] + mod[1] * amount]
  else
    mod = DIRECTIONS[mod]
    position = [position[0] + mod[0] * amount, position[1] + mod[1] * amount]
  end
end

puts position
puts position.sum

exit 0
