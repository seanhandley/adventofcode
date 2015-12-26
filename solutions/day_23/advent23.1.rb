#!/usr/bin/env ruby

# --- Day 23: Opening the Turing Lock ---
#
# Little Jane Marie just got her very first computer for Christmas from some unknown benefactor. It comes with @instructions and an example program, but the computer itself seems to be malfunctioning. She's curious what the program does, and would like you to help her run it.
#
# The manual explains that the computer supports two @registers and six @instructions (truly, it goes on to remind the reader, a state-of-the-art technology). The @registers are named a and b, can hold any non-negative integer, and begin with a value of 0. The @instructions are as follows:
#
# hlf r sets register r to half its current value, then continues with the next instruction.
# tpl r sets register r to triple its current value, then continues with the next instruction.
# inc r increments register r, adding 1 to it, then continues with the next instruction.
# jmp offset is a jump; it continues with the instruction offset away relative to itself.
# jie r, offset is like jmp, but only jumps if register r is even ("jump if even").
# jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one", not odd).
#
# All three jump @instructions work with an offset relative to that instruction. The offset is always written with a prefix + or - to indicate the direction of the jump (forward or backward, respectively). For example, jmp +1 would simply continue with the next instruction, while jmp +0 would continuously jump back to itself forever.
#
# The program exits when it tries to run an instruction beyond the ones defined.
#
# For example, this program sets a to 2, because the jio instruction causes it to skip the tpl instruction:
#
# inc a
# jio a, +2
# tpl a
# inc a
#
# What is the value in register b when the program in your puzzle input is finished executing?

@instructions = STDIN.read.split("\n")

def decode_instruction(instruction)
  instruction = instruction.dup
  command = instruction.slice!(0,3)
  args = instruction.split(',').map(&:strip)
  [command, args]
end

@registers = {
  'a' => 0,
  'b' => 0
}

@instruction_pointer = 0
@ticks = 0

def execute
  while(current_instruction = @instructions[@instruction_pointer])
    @ticks += 1
    command, args = decode_instruction(current_instruction)
    puts "#{@ticks.to_s.rjust(4, '0')}: [a: #{@registers['a'].to_s.rjust(5,'0')}, b: #{@registers['b'].to_s.rjust(5,'0')}] ##{@instruction_pointer.to_s.rjust(2, '0')} #{command.upcase} (#{args.join(', ')})"
    case command
    when 'hlf'
      @registers[args[0]] /= 2
      @instruction_pointer += 1
    when 'tpl'
      @registers[args[0]] *= 3
      @instruction_pointer += 1
    when 'inc'
      @registers[args[0]] += 1
      @instruction_pointer += 1
    when 'jmp'
      @instruction_pointer += args[0].to_i
    when 'jie'
      if @registers[args[0]] % 2 == 0
        @instruction_pointer += args[1].to_i
      else
        @instruction_pointer += 1
      end
    when 'jio'
      if @registers[args[0]] == 1
        @instruction_pointer += args[1].to_i
      else
        @instruction_pointer += 1
      end
    end
  end
  puts "Jumped to unknown location #{@instruction_pointer}. Exiting."
  @registers['b']
end

if $0 == __FILE__
  p execute
end
