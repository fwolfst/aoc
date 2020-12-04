#!/usr/bin/env ruby

# Puzzle 3: https://adventofcode.com/2020/day/2#part2
# Felix Wolfsteller

# X horizontal, Y vertical
X = 0
Y = 1
STEP = [3,1]

DEBUG = true

def is_tree? map, position, pattern_width
  if DEBUG
    puts map[position[Y]]
    x = position[X] % pattern_width
    if x > 0
      (x).times { putc " " }
    end
    puts "*"
    puts "tree at #{position[X] % pattern_width}? #{map[position[Y]][position[X] % pattern_width] == '#'}"
    puts
  end
  map[position[Y]][position[X] % pattern_width] == '#'
end


map = ARGF.readlines.map {|l| l.strip }

pattern_width = map[0].length
pattern_height = map.count


def do_step position
  position = [position[X] + STEP[X], position[Y] + STEP[Y]]
end

position = [0,0]

trees_on_path_count = 0
if is_tree? map, position, pattern_width
  trees_on_path_count = 1
end

# count trees
(pattern_height-1).times do |_num|
  if is_tree? map, position = do_step(position), pattern_width
    trees_on_path_count+= 1
  end
end

puts trees_on_path_count

exit 1
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
