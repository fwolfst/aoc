#!/usr/bin/env ruby

# Puzzle 4: https://adventofcode.com/2020/day/2#part2
# Felix Wolfsteller

values = ARGF.readlines.map {|l| [*l.split] }

correct_entries = 0

values.each do |entry|
  position_range, letter, password = entry

  positions = position_range.split("-").map(&:to_i)

  letter = letter[0]

  if (password[positions[0]-1] == letter) ^ (password[positions[1]-1] == letter)
    correct_entries+= 1
  end
end

puts correct_entries

exit 0
