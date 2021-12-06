#!/usr/bin/env ruby

# Puzzle 12: https://adventofcode.com/2021/day/6#part2
# Felix Wolfsteller

$DEBUG = (ARGV.delete '-d') ? true : false

def dputs string ; STDERR.puts string if $DEBUG ; end

dputs "enabled debugging output"

DAYS = 256

REPRODUCTION_RATE = 6
YOUNG_REPRODUCTION_RATE = 8

fish = ARGF.readlines(chomp: true).map{|l| l.split(",")}.flatten.map &:to_i

day_age_dist = {}

day_age_dist[0] = fish.tally

(1..DAYS).each do |day|
  today_dist = Hash.new {|h,k| h[k] = 0}

  age_dist = day_age_dist[day-1]
  age_dist.each do |age,count|
    if age == 0
      today_dist[REPRODUCTION_RATE] += count
      today_dist[YOUNG_REPRODUCTION_RATE] += count
    else
      today_dist[age-1] += count
    end
  end
  dputs "After %2s: %s" % [day, today_dist]

  day_age_dist[day] = today_dist
end

puts day_age_dist[DAYS].values.sum

exit 0

