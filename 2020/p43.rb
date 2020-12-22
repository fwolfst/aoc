#!/usr/bin/env ruby

require 'matrix'

# Puzzle 43: https://adventofcode.com/2020/day/22
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

decks = ARGF.read.split("\n\n").map(&:lines)

decks.each do |deck|
  deck.map!(&:chomp).map!(&:to_i)
  deck.shift
end

deck_player_1, deck_player_2 = decks

while (deck_player_1.size * deck_player_2.size) != 0
  card_player_1 = deck_player_1.shift
  card_player_2 = deck_player_2.shift

  dputs "playing #{card_player_1} vs #{card_player_2}"

  if card_player_2 > card_player_1
    deck_player_2 << card_player_2
    deck_player_2 << card_player_1
  else
    deck_player_1 << card_player_1
    deck_player_1 << card_player_2
  end
end

dputs "d1: #{deck_player_1}"
dputs "d2: #{deck_player_2}"

puts "Score: "
puts decks.find{|d| d.size != 0}.reverse.each_with_index.map{|c,idx| c * (idx + 1)}.sum

exit 1
