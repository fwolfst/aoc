#!/usr/bin/env ruby

# Puzzle 11: https://adventofcode.com/2021/day/6#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

REPRODUCTION_RATE = 6
YOUNG_REPRODUCTION_RATE = 8

fish = ARGF.readlines(chomp: true).map{|l| l.split(",")}.flatten.map &:to_i

(0..79).each do |day|
  dputs "After %2s: %s" % [day, fish.join(",")]

  offspring = fish.count 0

  fish.map! {|f| f==0 ? REPRODUCTION_RATE : f-1}

  fish << [YOUNG_REPRODUCTION_RATE] * offspring
  fish.flatten!
end

puts fish.count

exit 0
