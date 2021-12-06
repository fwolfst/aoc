#!/usr/bin/env ruby

# Puzzle 2: https://adventofcode.com/2021/day/1#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

distances = ARGF.readlines.map &:to_i

increases = 0
sums = distances.each_cons(3).map do |first, second, third|
  first + second + third
end

dputs sums

sums.each_cons(2) do |first,second|
  increases+=1 if second > first
end

puts increases

exit 0
