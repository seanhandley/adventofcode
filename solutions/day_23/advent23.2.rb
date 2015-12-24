#!/usr/bin/env ruby

# --- Day 23: Opening the Turing Lock ---
#
# --- Part Two ---
#
# The unknown benefactor is very thankful for releasi-- er, helping little Jane Marie with her computer. Definitely not to distract you, what is the value in register b after the program is finished executing if register a starts as 1 instead?

require_relative 'advent23.1'

@registers = {
  'a' => 1,
  'b' => 0
}

p execute
