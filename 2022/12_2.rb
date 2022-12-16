#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/12

require 'matrix'

interactive = ARGV.delete 'I'

SOURCE = (ARGV.delete 'D') ? DATA : ARGF
input = SOURCE.readlines.map &:chomp

puts "---"

world = Matrix[*input.map(&:chars)]
costs = Matrix.build(world.row_count, world.column_count) {Float::INFINITY}
starting_points = []
goal_point = []

world.each_with_index do |v, row, col|
  #costs[row, col] = 0 if v == 'S'
  world[row, col] = 'z' if v == 'E'
  world[row, col] = 'a' if v == 'S'
  goal_point = [row, col] if v == 'E'
  world[row, col] = world[row, col].ord - 'a'.ord
end

world.each_with_index do |v, row, col|
  starting_points << [row, col] if v == 0
  costs[row, col] = 0 if v == 0
end

UP    = [-1, 0]
DOWN  = [ 1, 0]
LEFT  = [ 0,-1]
RIGHT = [ 0, 1]
DIRS  = [UP, DOWN, LEFT, RIGHT]

def print_matrix matrix
  matrix.row_vectors.each do |row|
    puts row.to_a.map {|e| "%5d" %e  if !e.infinite?}.join
  end
end


print_matrix world

counter = 0

lengthes = starting_points.map do |starting_point|
  counter += 1
  
  p "#{counter}/#{starting_points.size}"

  costs[*starting_point] = 0

  paths = [ [ starting_point ] ] # owl
  while paths.size != 0
    #paths.sort_by! {|path| world[*path.last]} # be height-greedy
    paths.sort_by! {|path| (goal_point[0] - path.last[0]).abs + (goal_point[1] - path.last[1]).abs}.reverse! # be anti-manhattan
  
    path = paths.pop
    cur_cost   = path.length
    cur_height = world[*path.last]
  
    new_paths = DIRS.map do |dir|
      step_target = [path.last[0] + dir[0], path.last[1] + dir[1]]
      next if !step_target[0].between?(0, world.row_count - 1)
      next if !step_target[1].between?(0, world.column_count - 1)
      next if path.include? step_target
  
      if world[*step_target].between?(0, cur_height + 1) && costs[*step_target] > (path.size + 1)
        costs[*step_target] = path.size + 1
        path.dup << step_target
      else
        next
      end
    end.compact
  
    # dead end, dont need to revisit
    #if new_paths.empty?
    #  costs[*path.last] = 0
    #end
  
    new_paths.each do |new_path|
      paths << new_path
    end
  end
  costs[*goal_point]
end

p lengthes
p lengthes.min

binding.irb if interactive

__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
