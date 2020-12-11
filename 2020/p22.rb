#!/usr/bin/env ruby

# Puzzle 22: https://adventofcode.com/2020/day/11#part2
# Felix Wolfsteller

DEBUG = false

def dputs string
  puts string if DEBUG
end

OCCUPIED = '#'
EMPTY    = 'L'
FLOOR    = '.'

DIRS = [
  [-1,-1], [0,-1],  [1,-1],
  [-1, 0],          [1, 0],
  [-1, 1], [0, 1],  [1, 1]
]

class SeatMap
  attr_accessor :map

  def initialize map
    @map = map
  end

  def floor? x,y
    @map[y][x] == EMPTY
  end


  def empty? x,y
    @map[y][x] == EMPTY
  end

  def occupied? x,y
    @map[y][x] == OCCUPIED
  end

  def num_neighbours_occupied x,y
    [-1,0,1].each.count {|mod| occupied?(x+mod, y-1)} +
      [-1,0,1].each.count {|mod| occupied?(x+mod, y+1)} +
      [-1,1].each.count {|mod| occupied?(x+mod, y)}
  end

  def num_visible_neighbours_occupied x,y
    DIRS.count do |dir_x,dir_y|
      visible_occupied(x,y,dir_x,dir_y) > 0
    end
  end

  # cast a ray
  def visible_occupied x, y, dir_x, dir_y
    cursor_x, cursor_y = x, y
    while true
      cursor_x+= dir_x
      cursor_y+= dir_y
      if cursor_x < 0 || cursor_x >= width ||
        cursor_y < 0 || cursor_y >= height
        return 0
      elsif occupied?(cursor_x,cursor_y)
        return 1
      elsif empty?(cursor_x, cursor_y)
        return 0
      end
    end
    return 0 # reach that!
  end

  def build_floor_around!
    new_map = []
    new_map << Array.new(width + 2, FLOOR)
    @map.each do |row|
      new_map << [FLOOR, *row, FLOOR]
    end
    new_map << Array.new(width + 2, FLOOR)
    @map = new_map
  end

  def width ; @map[0].size ; end

  def height ; @map.size ; end

  def to_s
    @map.map do |row|
      row.join('')
    end.join("\n")
  end

  def map_num_nb
    new_map = Marshal.load(Marshal.dump(@map))
    @map[1..-2].each_with_index do |row,y|
      row[1..-2].each_with_index do |seat,x|
        new_map[y+1][x+1] = num_neighbours_occupied(x+1,y+1)
      end
    end
    new_map.map do |row|
      row.join('')
    end.join("\n")
  end

  def map_num_vis_nb
    new_map = Marshal.load(Marshal.dump(@map))
    @map[1..-2].each_with_index do |row,y|
      row[1..-2].each_with_index do |seat,x|
        new_map[y+1][x+1] = num_visible_neighbours_occupied(x+1,y+1)
      end
    end
    new_map.map do |row|
      row.join('')
    end.join("\n")
  end

  def occupy
    new_map = Marshal.load(Marshal.dump(@map))
    @map[1..-2].each_with_index do |row,y|
      row[1..-2].each_with_index do |seat,x|
        if seat == FLOOR
          # nop
        elsif seat == OCCUPIED && num_visible_neighbours_occupied(x+1,y+1) >= 5
          new_map[y+1][x+1] = EMPTY
        elsif seat == EMPTY && num_visible_neighbours_occupied(x+1,y+1) == 0
          new_map[y+1][x+1] = OCCUPIED
        end
      end
    end

    result = SeatMap.new new_map
    if result == self
      puts result
      raise "Stabilized at #{num_occupied}"
    end
    result
  end

  def num_occupied
    @map.map{|row| row.count{|s| s == OCCUPIED}}.sum
  end

  def ==(other)
    @map == other.map
  end
end

seat_map_data = ARGF.readlines.map(&:chomp).map{|l| l.chars}

seat_map = SeatMap.new seat_map_data

seat_map.build_floor_around!

while true
  seat_map = seat_map.occupy

  dputs seat_map
  if DEBUG
    gets
  end
end

exit 0
