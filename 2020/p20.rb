#!/usr/bin/env ruby

# Puzzle 20: https://adventofcode.com/2020/day/10#part2
# Felix Wolfsteller

DEBUG = false

def dputs string
  puts string if DEBUG
end

voltage_ratings = ARGF.readlines.map(&:strip).map(&:to_i)

voltage_ratings.sort!

voltage_ratings = [0, *voltage_ratings, voltage_ratings.last + 3]

differences = {}

voltage_ratings.each_cons(2) do |first_voltage, second_voltage|
  diff = second_voltage - first_voltage
  differences[diff] ||= 0
  differences[diff]+= 1
end

dputs voltage_ratings.inspect
puts "[1] #{differences}"
puts "[1]* #{differences[1] * differences[3]}"

# leaving the problem domain and looking from the solution, we could now map
# each value to the difference (0,2,3,5) -> (0,2-0,3-2,5-3)

# Divide and conquer
cut = 0
parts = []
voltage_ratings.each_with_index do |vr,idx|
  if idx == voltage_ratings.size - 2
    parts << voltage_ratings[cut..idx]
    break
  end
  if voltage_ratings[idx + 1] - vr == 3
    parts << voltage_ratings[cut..idx]
    cut = idx+1
  end
end

def good_combo? combo
  combo.each_cons(2).lazy.all?{|a,b| b-a <= 3}
end

dputs parts.map(&:inspect)

# Now how many combination of these are still okay?
valid_combo_by_part = parts.map do |part|
  dputs part.inspect
  if part.size == 1 || part.size == 2
    next 1
  end
  # First and last are "fixed". How many combinations of the middle parts are
  # okay?
  solution_count = (0..part.size - 2).map do |n|
    part[1..-2].combination(n).count do |c|
      c = [part[0], *c, part[-1]]
      dputs "#{c.inspect}: #{good_combo? c}"
      good_combo? c
    end
  end.sum
  dputs "*** #{solution_count}"

  solution_count
end

puts "[2]: #{valid_combo_by_part.inject(:*)}"

exit 0
