#!/usr/bin/env ruby

# Puzzle 13: https://adventofcode.com/2021/day/7#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

crap_pos = ARGF.read.scan(/\d+/).map &:to_i
min, max = crap_pos.minmax

costs = (min..max).map do |n|
  [n, crap_pos.map{|c| (c-n).abs}.sum]
end.to_h

puts costs.sort_by{|pos,cost| cost}.first

exit 0
