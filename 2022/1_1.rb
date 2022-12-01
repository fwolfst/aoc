#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/1

calories = ARGF.readlines.join.split("\n\n")

puts "---"

puts calories.map {|c| c.split.map(&:to_i).sum }.max
