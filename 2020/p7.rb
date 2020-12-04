#!/usr/bin/env ruby

# Puzzle 6: https://adventofcode.com/2020/day/4
# Felix Wolfsteller

DEBUG = false

PASSPORT_FIELDS = [
  "byr", # (Birth Year)
  "iyr", # (Issue Year)
  "eyr", # (Expiration Year)
  "hgt", # (Height)
  "hcl", # (Hair Color)
  "ecl", # (Eye Color)
  "pid", # (Passport ID)
  "cid", # (Country ID)
]

Passport = Struct.new(*PASSPORT_FIELDS.map(&:to_sym)) do
  def valid?
    byr && iyr && eyr && hgt && hcl && ecl && pid # && cid
  end
end

data = ARGF.read

# cut in passport data
passport_data_chunks = data.split("\n\n")

# parse single passport
passports = passport_data_chunks.map do |passwort_data|
  matches = passwort_data.gsub("\n", " ").scan(/[a-zA-Z]*:[a-zA-Z0-9#]*/)

  passport = Passport.new
  matches.each do |passport_entry|
    key,value = passport_entry.split(":")
    passport[key] = value
  end

  passport
end

puts passports.count {|p| p.valid? }

exit 0
