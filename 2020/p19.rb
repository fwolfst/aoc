#!/usr/bin/env ruby

# Puzzle 19: https://adventofcode.com/2020/day/10
# Felix Wolfsteller

voltage_ratings = ARGF.readlines.map(&:strip).map(&:to_i)

voltage_ratings.sort!

voltage_ratings = [0, *voltage_ratings, voltage_ratings.last + 3]

differences = {}

voltage_ratings.each_cons(2) do |first_voltage, second_voltage|
  diff = second_voltage - first_voltage
  differences[diff] ||= 0
  differences[diff]+= 1
end

puts "[1] #{differences}"
puts "[1]* #{differences[1] * differences[3]}"

exit 0
