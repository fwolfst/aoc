#!/usr/bin/env ruby

# Puzzle 27: https://adventofcode.com/2020/day/14#part2
# Felix Wolfsteller

$DEBUG = true

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

lines = ARGF.readlines.map(&:chomp)

memory = {}

def parse_mask line
  mask = line.split('=').last.chomp
  [:mask, mask]
end

def parse_memset line
  mem_part, value = line.split(" = ")
  mem_pos = mem_part.match(/[0-9]+/).to_s.to_i
  [mem_pos, value.to_i]
end

def apply_mask value, mask
  #s = value.to_s(2).rjust
  s = '%037b' % value
  dputs "(#{value}) s=>  #{s}"
  dputs "*msk #{mask}"
  mask.chars.each_with_index do |c,idx|
    if c == '0'
      s[idx] = '0'
    elsif c == '1'
      s[idx] = '1' end
  end
  dputs "i=> #{s.to_i} (s #{s})"
  s.to_i(2)
end

inputs = lines.map do |line|
  if line.start_with? 'mas'
    parse_mask line
  else
    parse_memset line
  end
end

mask = "0" * 36

inputs.each do |mem_pos, value|
  dputs "mem_pos value #{[mem_pos, value]}"
  if mem_pos == :mask
    mask = value
  else
    memory[mem_pos] = apply_mask(value, mask)
  end
end

puts memory.inspect
puts memory.values.sum

exit 0
