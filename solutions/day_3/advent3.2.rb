#!/usr/bin/env ruby

# --- Day 3: Perfectly Spherical Houses in a Vacuum ---
#
# --- Part Two ---
#
# The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.
#
# Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.
#
# For example:
#
# ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
# ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
# ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.
#
# This year, how many houses receive at least one present?

moves = STDIN.gets.chars

x, y = 0, 0
i, j = 0, 0
visited = []
visited << [x,y]
visited << [i,j]

moves.each_with_index do |move, index|
  case move
  when '^'
    (index % 2 == 0) ? y -= 1 : j -= 1
  when 'v'
    (index % 2 == 0) ? y += 1 : j += 1
  when '>'
    (index % 2 == 0) ? x += 1 : i += 1
  when '<'
    (index % 2 == 0) ? x -= 1 : i -= 1
  end
  index % 2 == 0 ? visited << [x,y] : visited << [i,j]
end

p visited.uniq.count