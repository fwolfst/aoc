#!/usr/bin/env ruby

# Puzzle 33: https://adventofcode.com/2020/day/17
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

Coordinate = Struct.new :x, :y, :z, keyword_init: true do
  def +(vector)
    Coordinate.new x: x + vector[0], y: y + vector[1], z: z + vector[2]
  end
end

ACTIVE = '#'
DIRECTIONS = ([-1,0,1].repeated_permutation(3).to_a - [[0,0,0]]).freeze

def count_neighbors world, coordinate
  DIRECTIONS.count do |dir|
    world[coordinate + dir]
  end
end

def puts_map world
  x_range = Range.new *world.keys.minmax{|a,b| a.x <=> b.x}.map(&:x)
  y_range = Range.new *world.keys.minmax{|a,b| a.y <=> b.y}.map(&:y)
  z_range = Range.new *world.keys.minmax{|a,b| a.z <=> b.z}.map(&:z)

  cursor = Coordinate.new
  z_range.each do |z|
    cursor.z = z
    puts "z=#{z}"

    y_range.each do |y|
      cursor.y = y

      x_range.each do |x|
        cursor.x = x
        if world[cursor]
          putc '#'
        else
          putc '.'
        end
      end
      puts
    end
  end

end

# map coordinates -> 
world = {}

ARGF.readlines.each_with_index do |row,row_idx|
  row.chomp.chars.each_with_index do |val,col_idx|
    if val == ACTIVE
      coordinate = Coordinate.new(x: col_idx, y: row_idx, z: 0)
      world[coordinate] = ACTIVE
    end
  end
end

dputs world

6.times do |_cycle|
  new_world = Marshal.load(Marshal.dump world)
  x_min_max = *world.keys.minmax{|a,b| a.x <=> b.x}.map(&:x)
  y_min_max = *world.keys.minmax{|a,b| a.y <=> b.y}.map(&:y)
  z_min_max = *world.keys.minmax{|a,b| a.z <=> b.z}.map(&:z)

  x_range = Range.new x_min_max.first - 1, x_min_max.last + 1
  y_range = Range.new y_min_max.first - 1, y_min_max.last + 1
  z_range = Range.new z_min_max.first - 1, z_min_max.last + 1

  dputs "X Range: %s" % x_range.inspect
  dputs "Y Range: %s" % y_range.inspect
  dputs "Z Range: %s" % z_range.inspect

  puts "After #{_cycle} cycle(s):"
  puts_map world

  cursor = Coordinate.new
  z_range.each do |z|
    cursor.z = z

    y_range.each do |y|
      cursor.y = y

      x_range.each do |x|
        cursor.x = x

        active_neighbours = count_neighbors world, cursor
        dputs "neighbours at #{cursor}: #{active_neighbours}"

        if world[cursor]
          if active_neighbours != 2 && active_neighbours != 3
            new_world.delete cursor
          end
        else
          if active_neighbours == 3
            new_world[cursor.dup] = ACTIVE
          end
        end
      end
    end
  end

  world = new_world
end

puts world.keys.count

exit 1
