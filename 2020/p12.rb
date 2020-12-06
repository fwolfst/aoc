#!/usr/bin/env ruby

# Puzzle 12: https://adventofcode.com/2020/day/6#part2
# Felix Wolfsteller

DEBUG = false

grouped_data = ARGF.read.split("\n\n")

sum = grouped_data.map do |group_answers|
  single_answers = group_answers.split("\n").map(&:chars)
  next single_answers[0].count if single_answers.count == 1

  intersecting_answers = single_answers[0]
  single_answers.each do |one_answer_set|
    intersecting_answers = intersecting_answers & one_answer_set
  end

  intersecting_answers.count
end.sum

puts "Sum:"
puts sum

exit 0
