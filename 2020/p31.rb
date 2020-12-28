#!/usr/bin/env ruby

# Puzzle 31: https://adventofcode.com/2020/day/16
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
tickets = []

sections = ARGF.read.split("\n\n")

rules_text, your_ticket, nearby_tickets = sections

rules_text.lines.each do |rule_line|
  rules << rule_line.scan(/[0-9]+-[0-9]+/)
    .map{|numbers| Range.new(*numbers.split("-").map(&:to_i)).to_a}.flatten
end

allowed_values = rules.flatten.uniq

bad_values = nearby_tickets.lines[1..-1].map do |ticket|
  dputs ticket

  values = ticket.split(",").map &:to_i
  bv = values.map do |value|
    next nil if allowed_values.include? value
    value
  end.compact.flatten

  dputs bv.inspect

  bv
end

dputs bad_values.inspect
dputs bad_values.flatten.compact.count
puts bad_values.flatten.compact.sum

exit 0
