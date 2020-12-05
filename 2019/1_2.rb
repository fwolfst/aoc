#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2019/day/1
# Felix Wolfsteller

input = ARGF.readlines.map {|l| l.to_i }

def calc_fuel mass
  fuel = mass / 3 -2
  fuel + ((fuel > 6) ? calc_fuel(fuel) : 0)
end

puts input
  .map{|mass| calc_fuel mass }
  .sum

exit 0
