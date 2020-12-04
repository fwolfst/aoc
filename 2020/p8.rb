#!/usr/bin/env ruby

# Puzzle 8: https://adventofcode.com/2020/day/4#part2
# Felix Wolfsteller

DEBUG = false

# field_name => validation_proc
PASSPORT_FIELDS = {
  "byr" => Proc.new { |v| # (Birth Year)
    v =~ /^[0-9]{4}$/ && (1920..2002).include?(v.to_i)
  },
  "iyr" => Proc.new { |v| # (Issue Year)
    v =~ /^[0-9]{4}$/ && (2010..2020).include?(v.to_i)
  },
  "eyr" => Proc.new { |v| # (Expiration Year)
    v =~ /^[0-9]{4}$/ && (2020..2030).include?(v.to_i)
  },
  "hgt" => Proc.new { |v|
    # hgt (Height) - a number followed by either cm or in:
    #   If cm, the number must be at least 150 and at most 193.
    #   If in, the number must be at least 59 and at most 76.
    (
      v.to_s.end_with?('in') && (59..76).include?(v.to_i)
    ) || (
      v.to_s.end_with?('cm') && (150..193).include?(v.to_i)
    )
  },
  "hcl" => Proc.new { |v| # (Hair Color)
    v =~ /^#[0-9a-f]{6}$/
  },
  "ecl" => Proc.new { |v| # (Eye Color)
    %w[amb blu brn gry grn hzl oth].include? v
  },
  "pid" => Proc.new { |v| # (Passport ID)
    v =~ /^[0-9]{9}$/
  },
  "cid" => Proc.new { true }, # (Country ID)
}

Passport = Struct.new(*PASSPORT_FIELDS.keys.map(&:to_sym)) do
  def valid?
    PASSPORT_FIELDS.each do |field, validator|
      return false if !validator.call(send(field.to_sym))
    end
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
