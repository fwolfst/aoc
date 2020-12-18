#!/usr/bin/env ruby

# Puzzle 36: https://adventofcode.com/2020/day/18#part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

OPERATORS = %w{+ * ( )}

stacks = ARGF.readlines.map do |line|
  tokens = line.gsub(/\s+/,'').chars

  stack = [[]]
  result = 0

  tokens.each do |token|
    if token == '('
      stack << []
    elsif token == ')'
      stack[-2] << stack.pop
    else
      stack.last << token
    end
  end

  stack
end

def reduce_exp array
  while array.size != 1
    dputs "Loop #{array}"
    if idx = array.index{|e| e.is_a? Array}
      array[idx] = reduce_exp array[idx]
    elsif idx = array.index('+')
      add = array[idx-1].to_i + array[idx+1].to_i
      array[idx-1] = add
      array.delete_at idx+1
      array.delete_at idx
    elsif idx = array.index('*')
      mult = array[idx-1].to_i * array[idx+1].to_i
      array[idx-1] = mult
      array.delete_at idx+1
      array.delete_at idx
    end
  end
  array.first
end

results = stacks.each do |task|
  reduce_exp(task.first)
end

puts results.inspect
puts results.flatten.sum

exit 1
