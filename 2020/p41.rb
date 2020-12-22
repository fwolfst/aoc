#!/usr/bin/env ruby

require 'matrix'

# Puzzle 41: https://adventofcode.com/2020/day/21 + #part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

recipies = ARGF.readlines

recipies.map! do |recipe|
  ingredients, allergenes = recipe.split("(")
  [ingredients.split(" "), allergenes.split(" ")[1..-1].map{|a| a.gsub(/[,)]/, '')}]
end

dputs recipies.inspect

all_allergenes = recipies.map{|r| r[1]}.flatten.uniq.compact

allergene_map = all_allergenes.map do |allergene|
  [allergene, recipies.map do |ingredients, contained_allergenes|
    if contained_allergenes.include? allergene
      ingredients
    else
      nil
    end
  end.compact
  ]
end.to_h

possible_allergene_ingredients = allergene_map.map do |allergene, possible_ingredients|
  dputs "allergene #{allergene}: #{possible_ingredients.inject(:&).inspect}"
  [allergene, possible_ingredients.inject(:&)]
end.to_h

dputs possible_allergene_ingredients.inspect

allergene_ingredient = {}

while !possible_allergene_ingredients.empty? do
  simple_solution = possible_allergene_ingredients.find{|allergene, possible_allergene_ingredients| possible_allergene_ingredients.count == 1}
  dputs simple_solution.inspect
  allergene_ingredient[simple_solution[0]] = simple_solution[1].first
  possible_allergene_ingredients.delete simple_solution[0]
  possible_allergene_ingredients = possible_allergene_ingredients.map do |allergene, possible_ingredients|
    possible_ingredients.delete simple_solution[1].first
    [allergene, possible_ingredients]
  end.to_h
  dputs possible_allergene_ingredients.inspect
end

dputs allergene_ingredient

puts "Solution 1 #{recipies.map{|r| (r[0] - allergene_ingredient.values).count}.sum}"
puts "Solution 2 #{allergene_ingredient.keys.sort.map{|a| allergene_ingredient[a]}.join(',')}"

exit 0
