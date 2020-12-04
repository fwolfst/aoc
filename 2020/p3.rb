#!/usr/bin/env ruby

# Puzzle 3: https://adventofcode.com/2020/day/2
# Felix Wolfsteller

values = ARGF.readlines.map {|l| [*l.split] }

correct_entries = 0

values.each do |entry|
  count_range, letter, password = entry

  count_range = Range.new *count_range.split("-").map(&:to_i)

  letter = letter[0]

  if count_range.include?(password.count(letter))
    correct_entries+= 1
  end
end

puts correct_entries


exit 0
