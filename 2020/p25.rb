#!/usr/bin/env ruby

# Puzzle 25: https://adventofcode.com/2020/day/13
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.count > 0 && ARGV[0] == '-d'
  $DEBUG = true
  dputs "enabled debugging output"
  ARGV.delete '-d'
end

lines = ARGF.readlines.map(&:chomp)

desired_departure_time = lines[0].to_i

schedules = lines[1].split(",").map do |bus_id_str|
  next nil if bus_id_str == 'x'
  
  bus_id = bus_id_str.to_i
  [bus_id, bus_id - desired_departure_time % bus_id]
end.compact.to_h

dputs schedules

min = 100_000
min_id = nil
schedules.each do |schedule, val|
  if val < min
    min = val
    min_id = schedule
  end
end

puts min
puts min_id
puts min * min_id

exit 0
