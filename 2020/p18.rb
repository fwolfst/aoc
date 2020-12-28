#!/usr/bin/env ruby

# Puzzle 18: https://adventofcode.com/2020/day/9#day2
# Felix Wolfsteller

DEBUG = true

lines = ARGF.readlines.map(&:strip).map(&:to_i)

parts = lines[0..24]

solution = nil

lines[25..-1].each do |number|
  if !parts.combination(2).map(&:sum).include? number
    solution = number
    break
  end
  parts.shift
  parts << number
end

cont_begin, cont_end = 0, 0
acc = lines[cont_begin]

puts solution

while acc != solution
  puts "#{acc} #{cont_begin}-#{cont_end}"

  acc += lines[cont_end+= 1]
  while (acc > solution)
    acc -= lines[cont_begin]
    cont_begin+= 1
  end
end

puts cont_begin, cont_end

puts lines[cont_begin..cont_end].minmax
puts "#{lines[cont_begin..cont_end].minmax.sum} -> #{solution}"

exit 0
