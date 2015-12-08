#!/usr/bin/env ruby

# --- Day 1: Not Quite Lisp ---
#
# --- Part Two ---
#
# Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.
#
# For example:
#
# ) causes him to enter the basement at character position 1.
# ()()) causes him to enter the basement at character position 5.
#
# What is the position of the character that causes Santa to first enter the basement?

input = STDIN.gets.chars
changes = input.map{|i| i == '(' ? 1 : -1}
@level = 0
changes.each_with_index{|i,index| @level += i; @level < 0 ? (p index + 1; break) : next}
