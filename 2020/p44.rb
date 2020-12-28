#!/usr/bin/env ruby

require 'matrix'

# Puzzle 43: https://adventofcode.com/2020/day/22#part2
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


# returns the winner
def play_game game_no, deck_player_1, deck_player_2
  dputs "=== Game #{game_no} ===\n\n"
  round = 1

  previous_decks= []

  while (deck_player_1.size * deck_player_2.size) != 0
    if previous_decks.include? [deck_player_1, deck_player_2]
      dputs "Infinite game prevention rule"
      return :one
    end

    previous_decks << [deck_player_1.dup, deck_player_2.dup]

    dputs "-- Round #{round} (Game #{game_no}) --"
    dputs "Player 1's deck: #{deck_player_1.join(', ')}"
    dputs "Player 2's deck: #{deck_player_2.join(', ')}"

    card_player_1 = deck_player_1.shift
    card_player_2 = deck_player_2.shift

    dputs "Player 1 plays: #{card_player_1}"
    dputs "Player 2 plays: #{card_player_2}"

    if deck_player_1.size >= card_player_1 && deck_player_2.size >= card_player_2
      sub_deck_player_1 = deck_player_1[0..card_player_1-1].dup
      sub_deck_player_2 = deck_player_2[0..card_player_2-1].dup
      dputs "On to recursive game"
      round_winner = play_game(game_no + 1, sub_deck_player_1, sub_deck_player_2)
    else
      round_winner = (card_player_2 > card_player_1) ? :two : :one
    end

    if round_winner == :one
      dputs "Player 1 wins the round #{round} of game #{game_no}!\n\n"
      deck_player_1 << card_player_1
      deck_player_1 << card_player_2
    else
      dputs "Player 2 wins the round #{round} of game #{game_no}!\n\n"
      deck_player_2 << card_player_2
      deck_player_2 << card_player_1
    end
    round += 1
  end

  if deck_player_1.size == 0
    dputs "The winner of game #{game_no} is player 2!\n\n"
    return :two
  else
    dputs "The winner of game #{game_no} is player 1!\n\n"
    return :one
  end
end

play_game(1, deck_player_1, deck_player_2)

puts "Score: "
puts decks.find{|d| d.size != 0}.reverse.each_with_index.map{|c,idx| c * (idx + 1)}.sum

exit 0

