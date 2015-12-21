#!/usr/bin/env ruby

# --- Day 20: Infinite Elves and Infinite Houses ---
#
# --- Part Two ---
#
# The Elves decide they don't want to visit an infinite number of houses. Instead, each Elf will stop after delivering presents to 50 houses. To make up for it, they decide to deliver presents equal to eleven times their number at each house.
#
# With these changes, what is the new lowest house number of the house to get at least as many presents as the number in your puzzle input?

lowest_presents = STDIN.gets.to_i

houses={1 => 0}

for elf in (1..1_000_000)
  for y in (1..50)
    house_number = elf * y
    houses[house_number] = 0 unless houses[house_number]
    houses[house_number] += elf*11
  end
end

p houses.select{|k,v| v >= lowest_presents}.keys.min
