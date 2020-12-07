#!/usr/bin/env ruby

# Puzzle 1: https://adventofcode.com/2019/day/1
# Felix Wolfsteller

program_source = ARGF.read

OPS = {
  RUN: nil,
  ADD: 1,
  MUL: 2,
  EOP: 99
}

module STATE
  RUN = 1
  EOP = 0
end

# source and state are horrible name choices here
Program = Struct.new(:source, :current_position, :state, keyword_init: true) do
  def execute_step!
    case source[current_position]
    when OPS[:ADD]
      first_arg_pos  = source[current_position + 1]
      second_arg_pos = source[current_position + 2]
      target_pos     = source[current_position + 3]

      source[target_pos] = source[first_arg_pos] + source[second_arg_pos]

      self.current_position= current_position + 4
    when OPS[:MUL]
      first_arg_pos  = source[current_position + 1]
      second_arg_pos = source[current_position + 2]
      target_pos     = source[current_position + 3]
      source[target_pos] = source[first_arg_pos] * source[second_arg_pos]
      self.current_position+= 4
    when OPS[:EOP]
      self.state = STATE::EOP
    else
      raise "UNKNOWN OP"
    end
  end
end

program = Program.new(
  source: program_source.split(",").map(&:to_i),
  current_position: 0,
  state: STATE::RUN
)

program.source[1] = 12
program.source[2] = 2

while program.state != STATE::EOP do
  program.execute_step!
end

puts program.source.inspect
puts program.source[0]

exit 0
