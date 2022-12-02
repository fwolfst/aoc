#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/1

strategy = ARGF.readlines

puts "---"

def xToA(symbol)
  return 'A' if symbol == 'X'
  return 'B' if symbol == 'Y'
  return 'C' if symbol == 'Z'
  raise 'ABCXYZ'
end

# 1 == symbol1, 2 == symbol2, 0 == draw
def who_wins?(symbol1, symbol2)
  if symbol1 == 'A'
    return 1 if symbol2 == 'C'
    return 2 if symbol2 == 'B'
    return 0
  elsif symbol1 == 'B'
    return 1 if symbol2 == 'A'
    return 2 if symbol2 == 'C'
    return 0
  else
    return 1 if symbol2 == 'B'
    return 2 if symbol2 == 'A'
    return 0
  end
end

def worth(symbol)
  case symbol
  when 'A'
    1
  when 'B'
    2
  when 'C'
    3
  end
end

points = strategy.map do |match|
  s1, s2 = match.split
  s2 = xToA(s2)
  case who_wins?(s1, s2)
  when 1
    0 + worth(s2)
  when 2
    6 + worth(s2)
  when 0
    3 + worth(s2)
  end
end

puts points.sum
