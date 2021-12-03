#!/usr/bin/env ruby

# Puzzle 5: https://adventofcode.com/2021/day/3#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines

bit_counts = []

lines.each do |line|
  bits = line.strip.chars
  bits.each_with_index do |bit, index|
    bit_counts[index] ||= {}
    bit_counts[index][bit] ||= 0
    bit_counts[index][bit]+=1
  end
end

dputs bit_counts

gamma = bit_counts.map do |bitcount|
  (bitcount["1"] > bitcount["0"]) ? 1 : 0
end

epsilon = gamma.map{|c| c == 1 ? 0 : 1 }
epsilon = epsilon.join.to_i(2)

gamma = gamma.join.to_i(2)

puts "gamma #{gamma}"
puts "epsilon #{epsilon}"

puts gamma * epsilon

exit 0
