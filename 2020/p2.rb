#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2020/day/1#part2
# Felix Wolfsteller

values = ARGF.readlines.map {|l| l.to_i }

searched_triple = []

values.uniq.each_with_index do |first_candidate, index|
  values[index..-1].each do |second_candidate|
    values[(index+1)..-1].each do |third_candidate|
      next if (first_candidate + second_candidate) > 2020

      if first_candidate + second_candidate + third_candidate == 2020
        searched_triple = [first_candidate, second_candidate, third_candidate]
        break
      end
    end
  end
end

puts "#{searched_triple.join('+')} = #{searched_triple.sum}"
puts "#{searched_triple.join('*')} = #{searched_triple.reduce(1, :*)}"

exit 0
