#!/usr/bin/env ruby

# Puzzle 9: https://adventofcode.com/2021/day/5#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

def horizontal_line? x1, y1, x2, y2
  y1 == y2
end
def vertical_line? x1, y1, x2, y2
  x1 == x2
end
def diagonal? x1, y1, x2, y2
  !horizontal_line?(x1,y1,x2,y2) && !vertical_line?(x1,y1,x2,y2)
end

def yield_line_points x1,y1,x2,y2
  if vertical_line?(x1,y1,x2,y2)
    ys = [y1,y2]
    (ys.min..ys.max).each do |y|
      yield Point.new(x1,y)
    end
  else
    xs = [x1,x2]
    (xs.min..xs.max).each do |x|
      yield Point.new(x,y1)
    end
  end
end

Point = Struct.new(:x, :y)

world = {}

lines = ARGF.readlines.map do |line|
  x1,y1,x2,y2 = line.strip.split(/[-,>]+/).map &:to_i
end

lines.select!{|l| !diagonal?(*l)}

lines.each do |line|
  dputs line.inspect
  yield_line_points(*line) do |point|
    world[point] ||= 0
    world[point]+=1
  end
end

puts world.values.count {|v| v > 1}

exit 0
