#!/usr/bin/env ruby

require 'matrix'

# Puzzle 37: https://adventofcode.com/2020/day/19 + #part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

class Tile
  attr_accessor :id, :pattern
  attr_accessor :rotation, :flip

  def initialize id:, pattern:
    @id      = id
    @pattern = Matrix[*pattern.map(&:chars)]
    @rotation = 0
    @flip     = 0
  end

  def borders
    [@pattern.row(0), @pattern.row(-1), @pattern.column(0), @pattern.column(-1)]
  end

  def possible_borders
    [@pattern.row(0), @pattern.row(-1),
     @pattern.column(0), @pattern.column(-1)] + [
       # include flipped variants
       @pattern.row(0), @pattern.row(-1),
       @pattern.column(0), @pattern.column(-1)
    ].map{|p| Vector[*p.to_a.reverse]}
  end

  def to_s
    "Tile #{id} #{pattern.inspect}"
  end
end

tiles = ARGF.read.split("\n\n")

tiles.map! do |tile|
  Tile.new id: tile.lines.first[5..8], pattern: tile.lines[1..-1].map(&:chomp)
end

puts tiles[0..1]
puts tiles[0].possible_borders

corner_tiles = []
# Find corner tiles
tiles.each_with_index do |tile,idx|
  count = (tiles - [tile]).count do |other_tile|
    (tile.possible_borders & other_tile.borders).any?
  end
  if count < 3
    corner_tiles << tile
  end
end

puts corner_tiles.count
puts corner_tiles.map(&:id).map(&:to_i).inject(:*)
puts corner_tiles.inspect

exit 0
