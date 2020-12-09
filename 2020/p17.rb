#!/usr/bin/env ruby

# Puzzle 17: https://adventofcode.com/2020/day/9
# Felix Wolfsteller

DEBUG = true

lines = ARGF.readlines.map(&:strip).map(&:to_i)

parts = lines[0..24]

lines[25..-1].each do |number|
  if !parts.combination(2).map(&:sum).include? number
    puts number
    exit 0
  end
  parts.shift
  parts << number
end

exit 0
