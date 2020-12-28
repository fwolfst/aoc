#!/usr/bin/env ruby

# Puzzle 32: https://adventofcode.com/2020/day/16#part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

rules = []

sections = ARGF.read.split("\n\n")

rules_text, your_ticket, nearby_tickets = sections

# rules[0] = [1,2,3,10,11,12,13] ...
rules_text.lines.each do |rule_line|
  rules << rule_line.scan(/[0-9]+-[0-9]+/)
    .map{|numbers| Range.new(*numbers.split("-").map(&:to_i)).to_a}.flatten
end

allowed_values = rules.flatten.uniq

good_tickets = nearby_tickets.lines[1..-1].map do |ticket|
  values = ticket.split(",").map &:to_i

  values.all?{|v| allowed_values.include? v} ? values : nil
end.compact

puts good_tickets.compact.count

possible_rule_indices = {}
definite_rules = Array.new rules_text.lines.count

rules_text.lines.each_with_index do |_l,i|
  possible_rule_indices[i] = (0..rules.count-1).to_a
end

values_by_rule_id = rules.each_with_index.map do |_,rule_idx|
  good_tickets.map{|t| t[rule_idx]}
end

rule_idx_map = {}

while !possible_rule_indices.keys.empty? do
  dputs "-> all leftover rules"
  possible_rule_indices.each do |rule_nr, possible_indices|
    dputs "  -> rule #{rule_nr} (possible at #{possible_indices.inspect})"

    possible_indices.each do |test_index|
      if values_by_rule_id[test_index].any? {|v| !rules[rule_nr].include? v}
        possible_indices.delete test_index
      else
      end
    end

    if possible_indices.count == 1
      rule_idx_map[rule_nr] = possible_indices.first
      possible_rule_indices.delete rule_nr
      possible_rule_indices.each do |rulenr,indices|
        indices.delete(possible_indices.first)
        possible_rule_indices[rulenr] = indices
      end
    end
  end
end

puts rule_idx_map.inspect

ticket = your_ticket.lines[1].split(",").map(&:to_i)

result = 1
rule_idx_map.each do |rule_nr, idx|
  if rule_nr < 6
    result *= ticket[idx]
  end
end

puts result

exit 0
