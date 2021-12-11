#!/usr/bin/env ruby

# Puzzle 19: https://adventofcode.com/2021/day/10#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string='' ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"


openers = ["(", "[", "{", "<"]
closers = [")", "]", "}", ">"]

cost = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

lines = ARGF.readlines(chomp: true)

incompletes = []
corrupted   = []
corrupters  = []

lines.each do |line|
  stash = []
  dputs line

  line.chars.each_with_index do |c,idx|
    if openers.include? c
      stash.push c
    else
      p = stash.last
      if openers.index(p) != closers.index(c)
        corrupted  << line
        corrupters << c
        break
      end
      stash.pop
    end
  end
  incompletes << line if stash.length != 0
end

dputs "incompletes:"
dputs incompletes
puts

dputs "corrupted"
dputs corrupted

dputs

dputs "corrupters"
dputs corrupters

dputs

score = corrupters.tally.reduce(0) do |points, count|
  points += cost[count[0]] * count[1]
end

puts score

exit 0
