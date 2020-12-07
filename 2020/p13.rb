#!/usr/bin/env ruby

# Puzzle 13: https://adventofcode.com/2020/day/7
# Felix Wolfsteller

DEBUG = true

rule_lines = ARGF.readlines.map(&:strip)

rule_contains = rule_lines.map{|l| l.split("contain", 2)}.to_h

# - 'bag(s)'
rule_contains.transform_keys! do |k|
  k = k.split(' ')[0..1].join(' ')
end

puts "#{rule_contains.keys.size} colors"

needles = ['shiny gold']

possible_outer_bags = []

while !needles.empty?
  rule_regexp = /(#{needles.join('|')})/
  outer_bags = rule_contains.select{|k,v| v =~ rule_regexp}

  if DEBUG
    puts rule_regexp
    puts "outer_: [#{outer_bags}]"
  end

  needles = outer_bags.keys

  possible_outer_bags += needles
end

puts possible_outer_bags.flatten.compact.uniq.count

exit 0
