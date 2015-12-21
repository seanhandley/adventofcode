#!/usr/bin/env ruby

# --- Day 19: Medicine for Rudolph ---
#
# --- Part Two ---
#
# Now that the machine is calibrated, you're ready to begin molecule fabrication.
#
# Molecule fabrication always begins with just a single electron, e, and applying replacements one at a time, just like the ones during calibration.
#
# For example, suppose you have the following replacements:
#
# e => H
# e => O
# H => HO
# H => OH
# O => HH
# If you'd like to make HOH, you start with e, and then make the following replacements:
#
# e => O to get O
# O => HH to get HH
# H => OH (on the second H) to get HOH
# So, you could make HOH after 3 steps. Santa's favorite molecule, HOHOHO, can be made in 6 steps.
#
# How long will it take to make the medicine? Given the available replacements and the medicine molecule in your puzzle input, what is the fewest number of steps to go from e to the medicine molecule?

input = STDIN.read.split("\n")

molecule = input[-1]

@transformations = {}
@electron_transformations = []

for line in (0..input.count-3)
  k, v = input[line].scan(/\A(\w+) => (\w+)\Z/).flatten

  if k == 'e'
    @electron_transformations << v
  else
    @transformations[v] = k
  end
end

@transformations = @transformations.sort_by { |from, to| from.length }.reverse

def step(molecule, step)
  if @electron_transformations.include?(molecule)
    p step 
    exit
  end

  @transformations.each do |from, to|
    molecule.match(from) do |m|
      s = molecule.clone
      s[m.begin(0)..m.end(0)-1] = to
      step(s, step + 1)
    end
  end
end

step(molecule, 1)
