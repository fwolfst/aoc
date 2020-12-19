#!/usr/bin/env ruby

# Puzzle 37: https://adventofcode.com/2020/day/19 + #part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

rules, inputs = ARGF.read.split("\n\n").map(&:lines)

rules  = rules.map(&:chomp)
inputs.map!(&:chomp)

rules.sort! do |r1,r2|
  r1.split(': ')[0].to_i <=> r2.split(": ")[0].to_i
end

rules.map! do |rule|
  rule = rule.split(": ")[1]
  rule = rule.split("|").map{|r| r.split(" ")}
  rule.map! do |tokens|
    tokens.map do |token|
      if token.start_with? '"'
        token.chars[1]
      else
        token.to_i
      end
    end
  end
  rule
end

rules.each_with_index do |rule,idx|
  dputs "#{idx.to_s.rjust 3}: #{rule.inspect}"
end

$rules = rules.dup

def find_path rules, input, path
  first_non_string_rule,idx = rules.each_with_index.find{|r,idx| !r.is_a? String}

  if idx.to_i > 0
    if rules[0..idx-1].join != input[0..idx-1]
      dputs "early exit: first chars dont match #{rules.inspect} #{input.inspect}"
      dputs "#{rules[0..idx-1].join} vs #{input[0..idx-1]}"

      return false
    end
  end

  if rules.length > input.length
    dputs "rule generation: too long"

    return false
  end

  dputs "eval #{rules.inspect} (#{path.inspect})"
  if first_non_string_rule
    dputs "replacing #{first_non_string_rule.inspect}"
    replacement_rule = $rules[first_non_string_rule]

    if replacement_rule.size > 1
      rules1 = rules.dup
      rules2 = rules.dup
      rules1[idx] = replacement_rule[0]
      rules2[idx] = replacement_rule[1]
      return find_path(rules1.flatten, input, path + [first_non_string_rule]) || find_path(rules2.flatten, input, path + [first_non_string_rule])
    else
      rules[idx] = replacement_rule
      return find_path(rules.flatten, input, path << first_non_string_rule)
    end
  else
    if rules.join == input
      return true
    else
      return false
    end
  end
end

count = 0
inputs.each do |input|
  puts "** Looking at #{input} **"
  if find_path(rules[0].first.dup, input, [0])
    count+= 1
  end
end

puts count

exit 1
