#!/usr/bin/env ruby

# Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character at a time.

# An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

# The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.

# For example:

# (()) and ()() both result in floor 0.
# ((( and (()(()( both result in floor 3.
# ))((((( also results in floor 3.
# ()) and ))( both result in floor -1 (the first basement level).
# ))) and )())()) both result in floor -3.
# To what floor do the instructions take Santa?

# Input: https://gist.githubusercontent.com/seanhandley/9cb9667b585081671381/raw/0ceb1b330964b7b6b0f9b69be28e1bc1f21cbd81/gistfile1.txt
input = STDIN.gets.chars
changes = input.map{|i| i == '(' ? 1 : -1}
p changes.reduce(:+)
