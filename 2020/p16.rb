#!/usr/bin/env ruby

# Puzzle 14: https://adventofcode.com/2020/day/8
# Felix Wolfsteller

DEBUG = true

module OPS
  ACC = 'acc'
  JMP = 'jmp'
  NOP = 'nop'
end

module STATE
  RUN        = 1
  TERMINATED = 0
  ERR        = 2
  PAUSED     = 3
end

Instruction = Struct.new(:op, :arg)

class Program
  attr_accessor :current_op_idx, :accumulator, :instructions,
    :passed_instruction_indexes, :state

  def initialize instructions
    @instructions = instructions
    reset!
  end

  def reset!
    @accumulator = 0
    @passed_instruction_indexes = []
    @current_op_idx = 0
    @state = STATE::PAUSED
  end

  # returns true on successfull execution
  def run!
    reset!
    @state = STATE::RUN
    #puts self.to_s

    while @state == STATE::RUN
      step!
    end

    if @current_op_idx == @instructions.size
      @state = STATE::TERMINATED
    end
  end

  def step!
    if @current_op_idx < 0
      @state = STATE::ERR
      return
    end

    if @current_op_idx == @instructions.size
      @state = STATE::TERMINATED
      return
    end

    if already_visitied? @current_op_idx
      @state = STATE::ERR
      return
    end

    instruction = @instructions[@current_op_idx]
    @passed_instruction_indexes << @current_op_idx
    case instruction.op
      when OPS::ACC
        @accumulator += instruction.arg
        @current_op_idx+= 1
      when OPS::JMP
        @current_op_idx+= instruction.arg
      when OPS::NOP
        @current_op_idx+= 1
    end
  end

  def to_s
    @instructions.each_with_index.map{|i,idx| "#{idx}:#{i.op} #{i.arg}"}.to_s
  end

  private
    def already_visitied? instruction_index
      @passed_instruction_indexes.include? instruction_index
    end
end

class Mutator
  def self.mutate instructions, idx
    instructions[idx..-1].each_with_index do |instruction,rel_idx|
      if instruction.op == OPS::NOP
        instruction.op = OPS::JMP
        return idx + 1 + rel_idx
      elsif instruction.op == OPS::JMP
        instruction.op = OPS::NOP
        return idx + 1 + rel_idx
      end
    end

    raise "MUTATOR: ERR Nothing left to mutate"
  end
end

instruction_lines = ARGF.readlines

instructions = instruction_lines.map{|line| line.split}.map{|op,arg| Instruction.new(op, arg.to_i)}

program = Program.new(instructions)
mutation_index = 0

while program.state != STATE::TERMINATED
  program.reset!

  program.instructions = instructions.map{|i| i.dup}
  mutation_index = Mutator.mutate(program.instructions,
    mutation_index)

  program.run!
end

puts program.accumulator

exit 0
