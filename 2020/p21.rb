#!/usr/bin/env ruby

# Puzzle 21: https://adventofcode.com/2020/day/11
# Felix Wolfsteller

DEBUG = false

def dputs string
  puts string if DEBUG
end

OCCUPIED = '#'
EMPTY    = 'L'
FLOOR    = '.'

class SeatMap
  attr_accessor :map

  def initialize map
    @map = map
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

  def build_floor_around!
    new_map = []
    new_map << Array.new(width + 2, FLOOR)
    @map.each do |row|
      new_map << [FLOOR, *row, FLOOR]
    end
    new_map << Array.new(width + 2, FLOOR)
    @map = new_map
  end

  def width
    @map.size
  end

  def height
    @map[0].size
  end

  def to_s
    @map.each do |row|
      puts row.join('')
    end
  end

  def puts_map_num_nb
    new_map = Marshal.load(Marshal.dump(@map))
    @map[1..-2].each_with_index do |row,y|
      row[1..-2].each_with_index do |seat,x|
        new_map[y+1][x+1] = num_neighbours_occupied(x+1,y+1)
      end
    end
    new_map.each do |row|
      puts row.join('')
    end
  end

  def occupy
    new_map = Marshal.load(Marshal.dump(@map))
    @map[1..-2].each_with_index do |row,y|
      row[1..-2].each_with_index do |seat,x|
        if seat == FLOOR
          # nop
        elsif seat == OCCUPIED && num_neighbours_occupied(x+1,y+1) >= 4
          new_map[y+1][x+1] = EMPTY
        elsif seat == EMPTY && num_neighbours_occupied(x+1,y+1) == 0
          new_map[y+1][x+1] = OCCUPIED
        end
      end
    end

    result = SeatMap.new new_map
    if result.num_occupied == num_occupied
      raise "Stabilized at #{num_occupied}"
    end
    result
  end

  def num_occupied
    @map.map{|row| row.count{|s| s == OCCUPIED}}.sum
  end
end

seat_map_data = ARGF.readlines.map(&:chomp).map{|l| l.chars}

seat_map = SeatMap.new seat_map_data
seat_map.build_floor_around!

dputs seat_map
#seat_map.puts_map_num_nb
#puts seat_map.num_occupied

next_map = seat_map.occupy
dputs next_map
#puts next_map.num_occupied
#next_map.puts_map_num_nb

while true
  next_map = next_map.occupy
end

exit 0
