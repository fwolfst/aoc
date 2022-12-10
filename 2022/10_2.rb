#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/10

require 'set'

cmds = ARGF.readlines.map &:strip

puts "---"

register = [0, 1]
curr = 1
pixbuf = Array.new(241, '.')

cmds.each do |cmd|
  cmd = cmd.split.last
  if cmd == 'noop'
    register[curr += 1] = register[curr - 1]
  else
    register[curr += 1] = register[curr - 1]
    register[curr += 1] = register[curr - 1] + cmd.to_i
  end
end

pixbuf.size.times do |idx|
  if (((idx -1) % 40) - register[idx] ).abs < 2
    pixbuf[idx] = ?#
  else
    pixbuf[idx] = ?.
  end
end

pixbuf[1..-1].each_slice(40) { |line| puts line.join }
