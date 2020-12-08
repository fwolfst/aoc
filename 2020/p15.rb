#!/usr/bin/env ruby

# Puzzle 14: https://adventofcode.com/2020/day/8
# Felix Wolfsteller

DEBUG = true

module OPS
  ACC = 'acc'
  JMP = 'jmp'
  NOP = 'nop'
end

Instruction = Struct.new(:op, :arg)

class Program
  attr_accessor :current_op_idx, :accumulator, :instructions, :passed_instruction_indexes

  def initialize instructions
    @instructions = instructions
    @accumulator = 0
    @passed_instruction_indexes = []
    @current_op_idx = 0
  end

  def run!
    while !(@passed_instruction_indexes.include? @current_op_idx)
      step!
    end
  end

  def step!
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
end

instruction_lines = ARGF.readlines

instructions = instruction_lines.map{|line| line.split}.map{|op,arg| Instruction.new(op, arg.to_i)}

program = Program.new(instructions)

program.run!

puts program.accumulator

exit 0
