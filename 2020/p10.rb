#!/usr/bin/env ruby

# Puzzle 10: https://adventofcode.com/2020/day/5#part2
# Felix Wolfsteller

DEBUG = false

PLANE_LENGTH = 128
PLANE_WIDTH = 8

data = ARGF.readlines

seats = data.map do |boarding_pass|
  row_range_start = 1
  row_range_end   = PLANE_LENGTH
  
  column_range_start = 1
  column_range_end   = PLANE_WIDTH
  
  row_range = (row_range_start..row_range_end)
  column_range = (column_range_start..column_range_end)
  
  boarding_pass[0..6].chars.each_with_index do |char,idx|
    half_size = row_range.size / 2
    if char == 'F'
      row_range_end-= half_size
    else
      row_range_start+= half_size
    end
    row_range = (row_range_start..row_range_end)
  end
  
  row = row_range.begin

  boarding_pass[7..10].chars.each_with_index do |char,idx|
    half_size = column_range.size / 2
    if char == 'L'
      column_range_end-= half_size
    else
      column_range_start+= half_size
    end
    column_range = (column_range_start..column_range_end)
  end

  column = column_range.begin

  [row-1, column-1]
end

seat_ids = seats.map do |row, column|
  row * 8 + column
end

puts seat_ids.max

# find missing seat id (search a whole of 1)
# brute force
seat_ids.sort.each_cons(3) do |before,middle,after|
  #puts "#{before}, #{middle}, #{after}"
  if before == middle -2
    puts "FOUND #{[before, middle, after]}"
    puts "missing seat: #{before + 1}"
    exit 1
  end
end


exit 0
