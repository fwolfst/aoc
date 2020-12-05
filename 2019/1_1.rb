#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2019/day/1
# Felix Wolfsteller

input = ARGF.readlines.map {|l| l.to_i }

puts input
  .map{|mass| mass / 3 -2}
  .sum

exit 0
