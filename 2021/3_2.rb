#!/usr/bin/env ruby

# Puzzle 5: https://adventofcode.com/2021/day/3#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines

lines_as_bits = lines.map {|l| l.strip.chars.map &:to_i}

def oxy_win_bit(array, position)
  zero_count = array.count {|a| a[position] == 0}
  one_count  = array.count {|a| a[position] == 1}
  return 1 if zero_count == one_count
  return 1 if one_count > zero_count
  return 0
end
 
def co2_win_bit(array, position)
  zero_count = array.count {|a| a[position] == 0}
  one_count  = array.count {|a| a[position] == 1}
  return 0 if zero_count == one_count
  return 0 if one_count > zero_count
  return 1
end

filtered = lines_as_bits.dup
filter_pos = 0

while filtered.count != 1
  win_bit = oxy_win_bit(filtered, filter_pos)
  dputs filtered.map &:join
  filtered.filter! {|f| f[filter_pos] == win_bit}

  dputs "** oxyfilter ##{filter_pos} (#{win_bit})**"
  dputs filtered.map &:join

  filter_pos += 1
end

oxygen = filtered.first.join.to_i 2

filtered = lines_as_bits.dup
filter_pos = 0

while filtered.count != 1
  win_bit = co2_win_bit(filtered, filter_pos)
  dputs filtered.map &:join
  filtered.filter! {|f| f[filter_pos] == win_bit}

  dputs "** co2filter ##{filter_pos} (#{win_bit})**"
  dputs filtered.map &:join

  filter_pos += 1
end

co2 = filtered.first.join.to_i 2

puts "oxy #{oxygen}"
puts "co2 #{co2}"

puts oxygen * co2

exit 0
