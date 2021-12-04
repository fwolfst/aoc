#!/usr/bin/env ruby

# Puzzle 8: https://adventofcode.com/2021/day/4#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

def draw_board board
  board.each do |row|
    puts row.map{|v| "%3s" % v}.join("")
  end
end

def win_score randoms, draw, bb
  called_numbers = randoms[0..randoms.index(draw)].map &:to_i
  # Remove the "counting borders"
  bb_numbers = bb.map{|r| r[0..BOARD_SIZE-1]}[0..-2].flatten.map &:to_i
  puts ((bb_numbers - called_numbers).sum * draw.to_i)
end
 
lines = ARGF.readlines

randoms = lines.first.split(",")

BOARD_SIZE = 5

board_blocks = lines[2..].each_slice(BOARD_SIZE + 1).map do |board_lines|
  board_lines.map(&:split).compact
end.compact

board_blocks.map! {|bb| bb.count == 6 ? bb[0..4] : bb}

# Add "counting borders" to count hits per col + row
board_blocks.each do |bb|
  bb.map{|r| r << 0}
  bb.push [0,0,0,0,0,0]
end

randoms.each do |draw|
  dputs "*" * 20
  dputs "draw #{draw}"

  board_blocks.each do |bb|
    bb[0..-1].each_with_index do |row, rowidx|
      row[0..-1].each_with_index do |v, colidx|
        if v == draw
          bb[rowidx][BOARD_SIZE]+=1
          bb[BOARD_SIZE][colidx]+=1

          # a board wins
          if bb[rowidx][BOARD_SIZE] == BOARD_SIZE || bb[BOARD_SIZE][colidx] == BOARD_SIZE
            dputs "#{board_blocks.count} blocks left"
            board_blocks -= [bb]
            if board_blocks.count == 0
              puts win_score(randoms, draw, bb)
              exit 0
            end
          end
        end
      end
    end
    if $DEBUG
      board_blocks.each {|bb|
        puts
        draw_board bb
        puts
      }
    end
  end
end


exit 0
