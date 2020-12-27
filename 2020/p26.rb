#!/usr/bin/env ruby

# Puzzle 26: https://adventofcode.com/2020/day/13#part2
# Felix Wolfsteller

require './p26_lib.rb'

$DEBUG = true

def dputs string
  puts string if $DEBUG
end

if ARGV.count > 0 && ARGV[0] == '-d'
  $DEBUG = true
  dputs "enabled debugging output"
  ARGV.delete '-d'
end

lines = ARGF.readlines.map(&:chomp)


# lazy enum 
def schedule bus_id, offset
  (0..).lazy.map do |num|
    offset + num * bus_id
  end
end

def rhythm bus_id_one, bus_id_two
  bus_id_one * bus_id_two
end

def brute_first_match bus_id_one, bus_offset_one, bus_id_two, bus_offset_two
  (0..).each do |t|
    if (bus_offset_one - t) % bus_id_one == 0 && (bus_offset_two - t) % bus_id_two == 0
      return t
    end
  end
end

def pretty_brute_first_match bus_id_one, bus_offset_one, bus_id_two, bus_offset_two
  #schedule(bus_id_two, bus_offset_two).each do |t|
  schedule(bus_id_one, bus_offset_one).each do |t|
    if (bus_offset_one - t) % bus_id_one == 0 && (bus_offset_two - t) % bus_id_two == 0
      return t
    end
  end
end

bus_schedules = lines[1].split(",").each_with_index.map do |bus_id_str, idx|
  next nil if bus_id_str == 'x'
  [bus_id_str.to_i, idx]
end.compact

puts "collapsing two busses into one"
remaining_buses = bus_schedules.dup

while remaining_buses.size > 1
  bus_one = remaining_buses.pop
  bus_two = remaining_buses.pop

  puts "bruting #{bus_one.inspect} and #{bus_two.inspect}"
  off = pretty_brute_first_match(bus_one[0], bus_one[1], bus_two[0], bus_two[1])
  pseudo_id = rhythm(bus_one[0], bus_two[0])

  remaining_buses << [pseudo_id, off]
end

puts remaining_buses.inspect
puts remaining_buses[0][0] - remaining_buses[0][1]

exit 0
