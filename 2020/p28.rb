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

def apply_bitmask value, mask
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

def mad_mask(mem_pos, mask)
  s = '%037b' % mem_pos
  dputs "(#{mem_pos}) s=>  #{s}"
  dputs "*msk #{mask}"

  decoded_addresses = []
  mad_fly_positions = []

  mask.chars.each_with_index do |c,idx|
    if c == '0'
    elsif c == '1'
      s[idx] = '1'
    elsif c == 'X'
      mad_fly_positions << idx
    end
  end

  mad_flies = mask.count('X')
  if mad_flies == 0
    return [s.to_i(2)]
  end
  parallel_universes = [0,1].repeated_permutation(mad_flies)
  #puts parallel_universes.to_a.inspect
  parallel_universes.each_with_index do |set|
    #puts "#{s}"
    mad_fly_positions.each_with_index do |mfp,idx|
      s[mfp] = set[idx].to_s
    end
    #puts "#{s}"
    #puts
    decoded_addresses << s.dup
  end
  puts "dec #{decoded_addresses} (mfps #{mad_fly_positions.size} + #{parallel_universes.size})"
  decoded_addresses.map{|s| s.to_i(2)}
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
    addresses = mad_mask(mem_pos, mask)
    addresses.each do |ad|
      memory[ad] = value
    end
  end
end

puts memory.inspect
puts memory.values.sum

exit 0
