#!/usr/bin/env ruby

# Puzzle 27: https://adventofcode.com/2020/day/14#part2
# Felix Wolfsteller

$DEBUG = true

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

numbers = ARGF.readlines.flatten.map{|l| l.split(",")}.flatten.map(&:to_i)

said = Array.new 2020
said[0..numbers.size-1] = numbers
said_pos = {}
numbers.each_with_index do |num,idx|
  said_pos[num] ||= []
  said_pos[num] << idx
end

said.each_with_index do |_,idx|
  next if idx < numbers.size
  last_said = said[idx-1]
  if said_pos[last_said] && said_pos[last_said].count == 1
    said[idx] = 0
  else
    said[idx] = said_pos[last_said].sort[-1] - said_pos[last_said].sort[-2]
  end
  said_pos[said[idx]] ||= []
  said_pos[said[idx]] << idx
end

puts said.inspect

puts said[2019]

exit 0
