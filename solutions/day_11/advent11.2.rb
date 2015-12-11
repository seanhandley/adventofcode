#!/usr/bin/env ruby

# --- Day 11: Corporate Policy ---
#
# --- Part Two ---
#
# Santa's password expired again. What's the next one?

require_relative 'advent11.1'

puts find_new_password(find_new_password(@password))
