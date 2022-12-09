#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/9

require 'set'

movements = ARGF.readlines.map &:strip

puts "---"

pos = {}
pos[:head] = [0,0]
pos[:tail] = pos[:head].dup

visit_list = Set.new
visit_list << pos[:tail].dup

mod = {
  "R" => [1,0],
  "L" => [-1,0],
  "U" => [0,-1],
  "D" => [0,1]
}

X = 0
Y = 1

# [x,y]
#
#    -1
# -1  0  1
#     1  
# --------> x

movements.map(&:split).each do |dir, steps|
  steps.to_i.times do
    pos[:head][X] += mod[dir][X]
    pos[:head][Y] += mod[dir][Y]

    [X,Y].select { (pos[:head][_1] - pos[:tail][_1]).abs > 1 }.each do |dim|
      puts "dim #{dim}"
      if pos[:head][dim] > pos[:tail][dim]
        pos[:tail][dim] +=1
      else
        pos[:tail][dim] -=1
      end

      other_dim = ([X,Y] - [dim]).first

      pos[:tail][other_dim] += 1 if pos[:tail][other_dim] < pos[:head][other_dim]
      pos[:tail][other_dim] -= 1 if pos[:tail][other_dim] > pos[:head][other_dim]

      visit_list << pos[:tail].dup
    end
  end
end

p visit_list.size
