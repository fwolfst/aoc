#!/usr/bin/env ruby

# Puzzle 30: https://adventofcode.com/2021/day/15#part2
# Felix Wolfsteller

require_relative '../lib/two_d/smatrix.rb'

lines = ARGF.readlines(chomp:true)

$world = TwoD::Smatrix.new(lines.count * 5, lines[0].length * 5)

lines.each_with_index do |row_line, row|
  row_line.chars.each_with_index do |risk_level, col|
    5.times do |r|
      5.times do |c|
        $world[col + c * $world.cols/5, row + r * $world.rows/5] = (risk_level.to_i + r + c-1) % 9 + 1
      end
    end
  end
end

$costs_to_end = TwoD::Smatrix.new(lines.count * 5, lines[0].length * 5)

# maximum: from here to end
$costs_to_end.each do |x,y,_v|
  $costs_to_end[x,y] = ($world.cols - x - 1) * 9 + ($world.rows - y - 1)
end

# costs from start to here
$costs_till = TwoD::Smatrix.new(lines.count * 5, lines[0].length * 5, value: Proc.new{Float::INFINITY})
$costs_till[0,0] = 0

current_cheapest_path_cost = ($world.cols - 1) * 9 + ($world.rows - 1) * 9

#puts "Initial state:"
#puts $world[-1,-1]
#$world.print!

def highlight_pos(x,y)
  Proc.new{|tx,ty,_v| x == tx && ty == y}
end

def highlight_posses(list)
  Proc.new{|tx,ty,_v| list.any?{|x,y,v| x==tx && ty == y}}
end

points_to_search = [[0,0]]
iterations      = 0
while point = points_to_search.shift
  draw = false #iterations % 100000 == 0

  iterations += 1
  if iterations % 10000 == 0
    puts "** Iteration #{iterations} (#{points_to_search.size})**"
    STDOUT.flush
  end

  x,y = point
  c   = $costs_till[x,y]

  next if c >= current_cheapest_path_cost
  next if c + $costs_to_end[x,y] >= current_cheapest_path_cost
  
  good_neighbours = $world.enum_for(:each_neighbour4,x,y).select do |nx,ny,nc|
    if (c + nc) < $costs_till[nx,ny]
      $costs_till[nx,ny] = c + nc
      true
    else
      false
    end
  end

  good_neighbours.sort_by {|nx,ny,nc| ((nx*ny < x*y)  ? 2 : 0) + $costs_till[nx,ny]}.reverse.each do |nx,ny,nc|
    points_to_search.unshift [nx,ny]
  end

  if good_neighbours.any? {|nx,ny,nc| nx == $world.cols - 1 && ny == $world.rows - 1}
    current_cheapest_path_cost = $costs_till[$world.cols - 1, $world.rows - 1]
    puts "New highscore: #{current_cheapest_path_cost}"
  end

  points_to_search.sort_by!{|x,y| $costs_till[x,y]}

  $world.print! highlight_proc: highlight_pos(x,y), highlight_proc2: highlight_posses(good_neighbours)
end

puts $costs_till[$costs_till.cols - 1, $costs_till.rows - 1]

exit 0
