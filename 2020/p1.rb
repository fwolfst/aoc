#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2020/day/1
# Felix Wolfsteller

values = ARGF.readlines.map {|l| l.to_i }

searched_pair = []

values.uniq.each_with_index do |first_candidate, index|
  values[index..-1].each do |second_candidate|
    if first_candidate + second_candidate == 2020
      searched_pair = [first_candidate, second_candidate]
      break
    end
  end
end

puts "#{searched_pair[0]} + #{searched_pair[1]} = #{searched_pair[0] + searched_pair[1]}"
puts "#{searched_pair[0]} * #{searched_pair[1]} = #{searched_pair[0] * searched_pair[1]}"

exit 0
