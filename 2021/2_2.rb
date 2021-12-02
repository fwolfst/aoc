#!/usr/bin/env ruby

# Puzzle 4: https://adventofcode.com/2021/day/2#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

Ship = Struct.new(:horizontal, :depth, :aim) do
  def forward x
    self.horizontal += x
    self.depth += self.aim * x
  end
  def down x
    self.aim += x
  end
  def up x
    self.aim -= x
  end
end

ship = Ship.new(0,0,0)
lines = ARGF.readlines.each do |action|
  cmd = action.split[0]
  arg = action.split[1]
  ship.send(cmd.to_s, arg.to_i)
  dputs ship
end

puts ship.horizontal * ship.depth

exit 0
