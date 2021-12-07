#!/usr/bin/env ruby

# Puzzle 14: https://adventofcode.com/2021/day/7#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

crap_pos = ARGF.read.scan(/\d+/).map &:to_i
min, max = crap_pos.minmax

cost_by_step = [0]
(1..max).each do |s|
  cost_by_step << cost_by_step[s-1] + s
end

costs = (min..max).map do |n|
  [n, crap_pos.map{|c| cost_by_step[(c-n).abs]}.sum]
end.to_h

puts costs.sort_by{|pos,cost| cost}.first

exit 0
