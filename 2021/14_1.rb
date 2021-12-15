#!/usr/bin/env ruby

# Puzzle 27: https://adventofcode.com/2021/day/14#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines(chomp: true)

polymer_template = lines[0]

rules = lines[2..-1].map{|l| l.split(" -> ")}

polymer_chain = polymer_template

1.upto(40).each do |step|
  next_chain = polymer_chain.chars.first
  polymer_chain.chars.each_cons(2) do |a,b|
    rule = rules.find{|rule| rule[0] == a+b}
    next_chain += rule[1] + b
  end
  polymer_chain = next_chain
end

counts = polymer_chain.chars.tally

max = counts.max_by{|letter,count| count}
min = counts.min_by{|letter,count| count}

puts max[1]-min[1]

exit 0
