#!/usr/bin/env ruby

# --- Day 16: Aunt Sue ---
#
# --- Part Two ---
#
# As you're about to send the thank you note, something in the MFCSAM's instructions catches your eye. Apparently, it has an outdated retroencabulator, and so the output from the machine isn't exact values - some of them indicate ranges.
#
# In particular, the cats and trees readings indicates that there are greater than that many (due to the unpredictable nuclear decay of cat dander and tree pollen), while the pomeranians and goldfish readings indicate that there are fewer than that many (due to the modial interaction of magnetoreluctance).
#
# What is the number of the real Aunt Sue?

require_relative 'advent16.1'

p matched_sue -> (other_sue, k, v) do
  if ['cats', 'trees'].include?(k)
    true if other_sue[k] > v
  elsif ['pomeranians', 'goldfish'].include?(k)
    true if other_sue[k] < v
  else
    true if other_sue[k] == v
  end
end
