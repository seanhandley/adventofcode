#!/usr/bin/env ruby

# --- Day 3: Perfectly Spherical Houses in a Vacuum ---
#
# Santa is delivering presents to an infinite two-dimensional grid of houses.
#
# He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.
#
# However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once.
#
# For example:
#
# > delivers presents to 2 houses: one at the starting location, and one to the east.
# ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
# ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
#
#  How many houses receive at least one present?

moves = STDIN.gets.chars

x, y = 0, 0
visited = []
visited << [x,y]
moves.each do |move|
  case move
  when '^'
    y -= 1
  when 'v'
    y += 1
  when '>'
    x += 1
  when '<'
    x -= 1
  end
  visited << [x,y]
end

p visited.uniq.count