#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2021/day/1#part1
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

lines = ARGF.readlines

exit 0
