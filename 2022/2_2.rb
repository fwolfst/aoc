#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/2

strategy = ARGF.readlines

puts "---"

def result_worth(r)
  return 6 if r == 'Z'
  return 3 if r == 'Y'
  return 0 if r == 'X'
end

def worth(symbol)
  return 1 if symbol == :rock
  return 2 if symbol == :paper
  return 3 if symbol == :scissor
end

def letter_to_symbol(letter)
  return :rock if letter == 'A'
  return :paper if letter == 'B'
  return :scissor if letter == 'C'
end

# feel the pride?
def response_worth(symbol, result)
  case result
  when 'X' # loose
    case symbol
    when :rock
      return worth(:scissor)
    when :paper
      return worth(:rock)
    when :scissor
      return worth(:paper)
    end
  when 'Y' # draw
    return worth(symbol)
  when 'Z' # win
    case symbol
    when :rock
      return worth(:paper)
    when :paper
      return worth(:scissor)
    when :scissor
      return worth(:rock)
    end
  end
end

points = strategy.map do |match|
  s1, r = match.split
  result_worth(r) + response_worth(letter_to_symbol(s1), r)
end

puts points.sum
