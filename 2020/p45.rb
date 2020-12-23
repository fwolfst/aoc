#!/usr/bin/env ruby

require 'matrix'

# Puzzle 45: https://adventofcode.com/2020/day/23
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

cups = '952316487'

cups = cups.chars.map(&:to_i)
current_cup_label = cups.first

def make_turn cups, current_cup_label
  dputs "cups: #{cups.map{|e| e == current_cup_label ? '(' + e.to_s + ')' : e.to_s}.join('  ')}"

  current_cup_idx = cups.index current_cup_label

  wrap_modulo = cups.length 
  picked_up = cups[(current_cup_idx + 1) % wrap_modulo], cups[(current_cup_idx + 2) % wrap_modulo], cups[(current_cup_idx + 3) % wrap_modulo]

  destination = current_cup_label - 1
  if destination < 1
    destination = cups.max
  end
  while picked_up.include? destination
    destination-= 1
    if destination < 1
      destination = cups.max
    end
  end

  # place cups
  cups.delete_if{|e| picked_up.include? e}
  destination_index = cups.index destination
  cups.insert destination_index + 1, *picked_up

  clockwise_of_current = cups[(cups.index(current_cup_label) + 1) % wrap_modulo]

  return cups, clockwise_of_current
end

100.times do |move|
  dputs "-- move #{move} --"
  cups, current_cup_label = make_turn cups, current_cup_label
  dputs ""
end

index_one = cups.index 1

dputs cups.inspect

result = (index_one+1..index_one+8).to_a.map do |t|
  cups[t % cups.size]
end

puts result.to_a.join

exit 0
