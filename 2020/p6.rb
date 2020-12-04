#!/usr/bin/env ruby

# Puzzle 6: https://adventofcode.com/2020/day/3#part2
# Felix Wolfsteller

# X horizontal, Y vertical
X = 0
Y = 1

DEBUG = false

def is_tree? map, position, pattern_width
  return false if position[Y] > map.size

  if DEBUG
    puts map[position[Y]]
    x = position[X] % pattern_width
    if x > 0
      (x).times { putc " " }
    end
    puts "*"
    puts "tree at #{position[X] % pattern_width}, #{position[Y]}? #{map[position[Y]][position[X] % pattern_width] == '#'}"
    puts
  end
  map[position[Y]][position[X] % pattern_width] == '#'
end

def do_step position, step_pattern
  position = [position[X] + step_pattern[X], position[Y] + step_pattern[Y]]
end

map = ARGF.readlines.map {|l| l.strip }

def count_occurrences step_pattern, map
  puts step_pattern
  pattern_width = map[0].length
  pattern_height = map.count
  puts "map of #{pattern_width} x #{pattern_height}"

  position = [0,0]

  trees_on_path_count = 0
  if is_tree? map, position, pattern_width
    trees_on_path_count = 1
  end
  
  # count trees
  (pattern_height-1).times do |_num|
    if is_tree? map, position = do_step(position, step_pattern), pattern_width
      trees_on_path_count+= 1
    end
  end

  trees_on_path_count
end

step_patterns = [
  [1,1],
  [3,1],
  [5,1],
  [7,1],
  [1,2],
]

counts = step_patterns.map do |step_pattern|
  count_occurrences step_pattern, map
end

puts counts
puts counts.reduce(1, :*)

exit 0

if DEBUG
  # puts debug map
  position = [0,0]
  
  (pattern_height-1).times do |_num|
    puts "check Y #{position[Y]} (#{pattern_height}), X #{position[X]} (#{pattern_width})"
    if is_tree? map, position = do_step(position), pattern_width
      map[position[Y]][position[X] % pattern_width] = 'X'
    else
      begin
      map[position[Y]][position[X] % pattern_width] = 'O'
    rescue
      puts position
    end
    end
  end
  
  puts map
end

exit 0
