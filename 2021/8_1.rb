#!/usr/bin/env ruby

# Puzzle 15: https://adventofcode.com/2021/day/8#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines

lines.map!(&:split)

input = lines.map {|l| [l[0..-6], l[-4..-1]]}

ONE_LENGTH = 2
FOUR_LENGTH = 4
SEVEN_LENGTH = 3
EIGHT_LENGTH = 7

TARGET_SIZES = [ONE_LENGTH, FOUR_LENGTH, SEVEN_LENGTH, EIGHT_LENGTH]

counts = input.map do |pattern|
  pattern[1].count{|e| TARGET_SIZES.include? e.size}
end

puts counts.sum

exit 0
