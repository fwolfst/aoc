#!/usr/bin/env ruby

require 'matrix'

# Puzzle 47: https://adventofcode.com/2020/day/24
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

lines = ARGF.readlines.map(&:chomp)

lines.map! do |line|
  line = line.scan(/(se|ne|sw|nw|e|w)/).flatten
end

max = lines.map{|l| l.size}.max

map = Matrix.zero (max*2 + 1)

puts lines.inspect

lines.each do |line|
  cursor = [max/2,max/2]
  line.each do |direction|
    case direction
    when 'se'
      cursor[1] = cursor[1] + 1
      cursor[0] = cursor[0] + 1
    when 'e'
      cursor[0] = cursor[0] + 1
    when 'w'
      cursor[0] = cursor[0] - 1
    when 'sw'
      cursor[1] = cursor[1] + 1
    when 'nw'
      cursor[1] = cursor[1] - 1
      cursor[0] = cursor[0] - 1
    when 'ne'
      cursor[1] = cursor[1] - 1
    when 'w'
      cursor[0] = cursor[0] - 1
    else
      raise "unknown direction #{direction}"
    end
  end
  dputs cursor.inspect

  if map[cursor[1], cursor[0]] == 0
    map[cursor[1], cursor[0]] = 1
  else
    dputs "flip back to white"
    map[cursor[1], cursor[0]] = 0
  end
end

puts map

count = 0
map.each do |e|
  count+=1 if e == 1
end

puts lines.count
puts count

exit 0
