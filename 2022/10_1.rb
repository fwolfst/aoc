#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/10

require 'set'

cmds = ARGF.readlines.map &:strip

puts "---"

register = [0, 1]
curr = 1

cmds.each do |cmd|
  cmd = cmd.split.last
  if cmd == 'noop'
    register[curr += 1] = register[curr - 1]
  else
    register[curr += 1] = register[curr - 1]
    register[curr += 1] = register[curr - 1] + cmd.to_i
  end
end

puts [20,60,100,140,180,220].sum {
  _1 * register[_1]
}
