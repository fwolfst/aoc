#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/9

require 'set'

movements = ARGF.readlines.map &:strip

puts "---"

HEAD = 0
TAIL = 9
pos = []
(HEAD..TAIL).to_a.each { pos[_1] = [0,0] }

visit_list = Set.new
visit_list << pos[TAIL].dup

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

def print(pos)
  map = []
  (0..30).to_a.each do |y|
    map[y] = []
    (0..40).to_a.each do |x|
      x_o = x - 20
      y_o = y - 18
      if m = pos.index([x_o, y_o])
        map[y][x] = m
      elsif x_o * y_o == 0
        map[y][x] = 'X'
      else
        map[y][x] = '.'
      end
    end
  end

  map.each do |row|
    puts row.join
  end
end

turn = 0

movements.map(&:split).each do |dir, steps|
  steps.to_i.times do
    turn += 1
    puts "TURN #{turn} #{dir} #{steps}"

    debug = (8..11).include? turn

    if debug
      puts pos.inspect
      print(pos)
      puts
    end

    pos[HEAD][X] += mod[dir][X]
    pos[HEAD][Y] += mod[dir][Y]

    (HEAD..TAIL).to_a.each_cons(2) do |head_idx, follow_idx|
      [X,Y].select { (pos[head_idx][_1] - pos[follow_idx][_1]).abs > 1 }.each do |dim|
        # skip if already adjacent - this is the faster but worse fix
        next if [X,Y].map { (pos[head_idx][_1] - pos[follow_idx][_1]).abs }.max <= 1

        if pos[head_idx][dim] > pos[follow_idx][dim]
          pos[follow_idx][dim] +=1
        else
          pos[follow_idx][dim] -=1
        end

        other_dim = ([X,Y] - [dim]).first

        pos[follow_idx][other_dim] += 1 if pos[follow_idx][other_dim] < pos[head_idx][other_dim]
        pos[follow_idx][other_dim] -= 1 if pos[follow_idx][other_dim] > pos[head_idx][other_dim]

        visit_list << pos[follow_idx].dup if follow_idx == TAIL
      end
    end
  end
end

p visit_list.size
