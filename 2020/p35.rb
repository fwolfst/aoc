#!/usr/bin/env ruby

# Puzzle 35: https://adventofcode.com/2020/day/18
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

  nestedness = 0
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

def calc stack
  result = 0
  operation = nil
  stack.each do |exp|
    if exp.is_a? Array
      case operation
      when '+'
        operation = nil
        result+= calc exp
      when '*'
        operation = nil
        result*= calc exp
      else
        result = calc exp
      end
    elsif OPERATORS.include? exp
      operation = exp
    else
      case operation
      when '+'
        operation = nil
        result+= exp.to_i
      when '*'
        operation = nil
        result*= exp.to_i
      else
        result = exp.to_i
      end
    end
  end

  result
end

stacks.each{|s| dputs s.inspect}

puts stacks.map{|s| calc s.first}.sum

exit 1
