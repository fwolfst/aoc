#!/usr/bin/env ruby

# Puzzle 16: https://adventofcode.com/2021/day/8#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

NUM_LETTERS = {
  0 => "abcefg",
  1 => "cf",
  2 => "acdeg",
  3 => "acdfg",
  4 => "bcdf",
  5 => "abdfg",
  6 => "abdefg",
  7 => "acf",
  8 => "abcdefg",
  9 => "abcdfg",
  fuckyou: 'afd'
}

lines = ARGF.readlines

lines.map!(&:split)

input = lines.map {|l| [l[0..-6], l[-4..-1]]}

def to_digit(lettermap, input)
  real_letters = input.chars.map{|l| lettermap.invert[l]}
  NUM_LETTERS.find{|k,v| v == real_letters.sort.join}.first
end

def to_number(lettermap, input)
  input.map{|i| to_digit(lettermap,i)}.join.to_i
end

counts = input.map do |pattern|
  lettermap = {}

  all_letter_count = pattern[0].join.chars.tally

  lettermap["a"] = (pattern[0].find{|e| e.size == 3}.chars - pattern[0].find{|e| e.size == 2}.chars).first

  lettermap["b"] = all_letter_count.select{|l,c| c == 6}.keys[0]
  lettermap["c"] = all_letter_count.select{|l,c| l != lettermap["a"] && c == 8}.keys[0]

  lettermap["d"] = all_letter_count.select{|l,c| c == 7 && pattern[0].find{|e|e.size == 4}.chars.include?(l)}.keys[0]
  lettermap["e"] = all_letter_count.select{|l,c| c == 4}.keys[0]
  lettermap["f"] = all_letter_count.select{|l,c| c == 9}.keys[0]
  lettermap["g"] = ("abcdefg".chars - lettermap.values).first

  dputs lettermap

  to_number(lettermap, pattern[1])
end

puts counts.sum

exit 0
