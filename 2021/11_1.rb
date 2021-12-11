#!/usr/bin/env ruby

# Puzzle 21: https://adventofcode.com/2021/day/11#part1
# Felix Wolfsteller

require 'colorize'

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

SIZE = 10

$world = []

def worldprint
  $world.each do |row|
    row.each do |v|
      print "%3s".red % v if v == 0
      print "%3s"     % v if v != 0
    end
    puts
  end
end

lines = ARGF.readlines(chomp:true)
lines.each_with_index do |line,row|
  $world[row] ||= []
  line.chars.map(&:to_i).each_with_index do |octo,col|
    $world[row][col] = octo
  end
end

def inc_world_around(row, col)
  [-1,0,1].each do |hor|
    c = col + hor
    next if c < 0 || c >= SIZE
    [-1,0,1].each do |ver|
      r = row + ver
      if r >= 0 && r < SIZE
        $world[r][c] += 1 if $world[r][c] != 0
      end
    end
  end
end

flashes = 1.upto(11100).map do |step|
  $world.map!{|r| r.map{|c| c+1}}
  puts "step " + step.to_s + " *"  * 10

  this_steps_flashes = 0

  flashed_this_iter = $world.flatten.any? 10
  while flashed_this_iter
    flashed_this_iter = false
    0.upto(SIZE-1).each do |row|
      0.upto(SIZE-1).each do |col|
        if $world[row][col] > 9
          $world[row][col] = 0
          inc_world_around(row, col)
          flashed_this_iter = $world.flatten.any? {|i| i > 9}
        end
        next
      end
    end
  end

  worldprint
  puts

  this_steps_flashes = $world.flatten.count 0
end

puts flashes.sum

exit 0
