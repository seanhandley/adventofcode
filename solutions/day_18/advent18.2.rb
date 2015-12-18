#!/usr/bin/env ruby

# --- Day 18: Like a GIF For Your Yard ---
#
# --- Part Two ---
#
# You flip the instructions over; Santa goes on to point out that this is all just an implementation of Conway's Game of Life. At least, it was, until you notice that something's wrong with the grid of lights you bought: four lights, one in each corner, are stuck on and can't be turned off. The example above will actually run like this:
#
# Initial state:
# ##.#.#
# ...##.
# #....#
# ..#...
# #.#..#
# ####.#
#
# After 1 step:
# #.##.#
# ####.#
# ...##.
# ......
# #...#.
# #.####
#
# After 2 steps:
# #..#.#
# #....#
# .#.##.
# ...##.
# .#..##
# ##.###
#
# After 3 steps:
# #...##
# ####.#
# ..##.#
# ......
# ##....
# ####.#
#
# After 4 steps:
# #.####
# #....#
# ...#..
# .##...
# #.....
# #.#..#
#
# After 5 steps:
# ##.###
# .##..#
# .##...
# .##...
# #.#...
# ##...#
# After 5 steps, this example now has 17 lights on.
#
# In your grid of 100x100 lights, given your initial configuration, but with the four corners always in the on state, how many lights are on after 100 steps?

require_relative 'advent18.1'

state = start_lights

100.times do
  state = next_state(state) do |lights, next_s, x, y|
    next if x == 0 && y == 0
    next if x == 0 && y == 99
    next if x == 99 && y == 0
    next if x == 99 && y == 99
    if lights[x][y] == '.'
      if neighbours(lights, x, y).select{|n| n == '#'}.count == 3
        next_s[x][y] = '#'
      end
    else
      on = neighbours(lights, x, y).select{|n| n == '#'}.count
      next_s[x][y] = '.' unless [2,3].include?(on)
    end
  end
end

p count_on(state)
