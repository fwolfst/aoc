#!/usr/bin/env ruby

# Puzzle 20: https://adventofcode.com/2021/day/10#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

openers = ["(", "[", "{", "<"]
closers = [")", "]", "}", ">"]

cost = {
  ")" => 3,
  "(" => 1,
  "]" => 57,
  "[" => 2,
  "}" => 1197,
  "{" => 3,
  ">" => 25137,
  "<" => 4
}

lines = ARGF.readlines(chomp: true)

incompletes = {}
corrupted   = []
corrupters  = []

lines.each do |line|
  stash = []

  is_corrupted = false
  line.chars.each_with_index do |c,idx|
    if openers.include? c
      stash.push c
    else
      p = stash.last
      if openers.index(p) != closers.index(c)
        corrupted  << line
        corrupters << c
        is_corrupted = true
      end
      stash.pop
    end
  end
  incompletes[line] = stash if !stash.empty? && !is_corrupted
end

scores = incompletes.map do |incomplete, stash|
  score = stash.reverse.reduce(0) do |collector, unclosed|
    collector * 5 + cost[unclosed]
  end
  score
end

scores.sort!

puts scores[scores.length / 2]

exit 0
