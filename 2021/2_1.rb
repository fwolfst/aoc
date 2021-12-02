#!/usr/bin/env ruby

# Puzzle 3: https://adventofcode.com/2021/day/2#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

Position = Struct.new(:horizontal, :depth) do
  def forward x
    self.horizontal += x
  end
  def down x
    self.depth += x
  end
  def up x
    self.depth -= x
  end
end

position = Position.new(0,0)
lines = ARGF.readlines.each do |action|
  cmd = action.split[0]
  arg = action.split[1]
  position.send(cmd.to_s, arg.to_i)
  dputs position
end

puts position.horizontal * position.depth

exit 0
