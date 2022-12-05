#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/5

input = ARGF.read

puts "---"

stacks_input, instructions = input.split("\n\n").map{ _1.split("\n") }

num_stacks = (stacks_input.first.length) / 4 + 1

height = stacks_input.size - 1
stacks = []

(0..(height - 1)).to_a.reverse.each do |y|
  num_stacks.times do |x|
    (stacks[x] ||= []) << stacks_input[y][1+x*4]
  end
end

stacks.map!{_1.reject {|v| v == ' '}}

instructions.each do |instruction|
  num, from, to = instruction.scan(/\d+/)
  stacks[to.to_i - 1].push *stacks[from.to_i - 1].pop(num.to_i)
  p stacks
end

p stacks.map(&:last).join
