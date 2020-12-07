#!/usr/bin/env ruby

# Puzzle 3: https://adventofcode.com/2019/day/2#part2
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
# actually, part2 nicely defines the terminology, but I rush and will leave as
# is
class Program
  attr_accessor :source, :state

  def initialize source:, current_position: 0, state: STATE::RUN
    @source = source
    @current_position = current_position
    @state = state
  end

  def execute_step!
    case @source[@current_position]
    when OPS[:ADD]
      first_arg_pos, second_arg_pos, target_pos = sanitize_args

      @source[target_pos] = @source[first_arg_pos] + @source[second_arg_pos]

      @current_position+= 4
    when OPS[:MUL]
      first_arg_pos, second_arg_pos, target_pos = sanitize_args

      @source[target_pos] = @source[first_arg_pos] * @source[second_arg_pos]

      @current_position+= 4
    when OPS[:EOP]
      @state = STATE::EOP
    else
      raise "UNKNOWN OP"
    end
  end

  def result
    @state == STATE::EOP ? @source[0] : nil
  end

  def compute!
    while @state != STATE::EOP do
      execute_step!
    end

    result
  end

  private

    def sanitize_args
      first_arg_pos  = @source[@current_position + 1]
      second_arg_pos = @source[@current_position + 2]
      target_pos     = @source[@current_position + 3]
      if [first_arg_pos, second_arg_pos, target_pos].any? {|v| v >= @source.size}
        raise "OUT OF RANGE"
      end

      [first_arg_pos, second_arg_pos, target_pos]
    end
end

program = Program.new(
  source: program_source.split(",").map(&:to_i),
  current_position: 0,
  state: STATE::RUN
)

noun = 0
verb = 0

# verb goes first
while program.compute! != 19690720 do

  program = Program.new(
    source: program_source.split(",").map(&:to_i),
    current_position: 0,
    state: STATE::RUN
  )
  if verb == noun
    noun = 0
    verb += 1
  else
    noun+= 1
  end
  program.source[1] = noun
  program.source[2] = verb
end

puts noun
puts verb
puts "= #{100 * noun + verb}"

exit 0
