#!/usr/bin/env ruby

# Puzzle 11: https://adventofcode.com/2020/day/6
# Felix Wolfsteller

DEBUG = false

grouped_data = ARGF.read.split("\n\n")

sum = grouped_data.map do |group_answers|
  group_answers.gsub("\n",'').chars.uniq.count
end.sum

puts sum

exit 0
