#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/4

list = ARGF.readlines

puts "---"

ranges = list.map do |line|
  line.split(/,/).map do |range_def|
    values = range_def.split('-').map(&:to_i)
    values[0]..values[1]
  end
end

count = ranges.count do |ranges|
  (ranges.first.include?(ranges.last.min) || ranges.first.include?(ranges.last.max)) ||
    ranges.first.cover?(ranges.last) || ranges.last.cover?(ranges.first)
end

puts count
