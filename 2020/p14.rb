#!/usr/bin/env ruby

# Puzzle 14: https://adventofcode.com/2020/day/7#part2
# Felix Wolfsteller

DEBUG = true

rule_lines = ARGF.readlines.map(&:strip)

$rules = rule_lines.map{|l| l.split("contain", 2)}.to_h

# only store colors
$rules.transform_keys! do |k|
  k = k.split(' ')[0..1].join(' ')
end

$rules.transform_values! do |v|
  matches = v.scan /(?<number>[0-9]+) (?<color>\w* \w*) bag[s]?/
  matches.map{|num,col| [col,num.to_i]}.to_h
end

def count_bags(col)
  counts = ($rules[col] || []).map do |inside_col, inside_num|
    inside_num * count_bags(inside_col)
  end

  if counts.flatten.sum == 0
    return 1
  else
   return counts.flatten.sum + 1
  end
end

puts count_bags('shiny gold') -1

exit 0
