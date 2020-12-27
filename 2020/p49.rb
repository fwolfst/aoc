#!/usr/bin/env ruby

require 'matrix'

# Puzzle 49: https://adventofcode.com/2020/day/25
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

door_public_key, card_public_key = ARGF.readlines.map(&:chomp).map(&:to_i)

def transform_step subject_number, value
  value *= subject_number
  value %= 20201227
end

def transform subject_number, value, loop_size
  loop_size.times do |_iteration|
    value = transform_step(subject_number, value)
  end
  value
end

# card_loop_size # specific
# door_loop_size # always different, secret

# card_public_key # transform(7, 1, card_loop_size)
# door_public_key # transform(7, 1, door_loop_size)

# encryption_key #   ( transform(door_public_key, 1, card_loop_size)
#                # ==  transform(card_public_key, 1, door_loop_size) )

door_loop_size = 1
key = transform_step(7,1)
while key != door_public_key
  key = transform_step(7,key)
  door_loop_size = door_loop_size + 1
  if door_loop_size % 10000 == 0
    putc "."
  end
end
puts
puts door_loop_size
puts

card_loop_size = 1
key = transform_step(7,1)
while key != card_public_key
  key = transform_step(7,key)
  card_loop_size = card_loop_size + 1
  if card_loop_size % 10000 == 0
    putc "."
  end
end
puts
puts card_loop_size

puts "encryption key (card) #{transform(door_public_key, 1, card_loop_size)}"
puts "encryption key (door) #{transform(card_public_key, 1, door_loop_size)}"

exit 0

