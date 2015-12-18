#!/usr/bin/env ruby

# --- Day 18: Like a GIF For Your Yard ---

# After the million lights incident, the fire code has gotten stricter: now, at most ten thousand lights are allowed. You arrange them in a 100x100 grid.
#
# Never one to let you down, Santa again mails you instructions on the ideal lighting configuration. With so few lights, he says, you'll have to resort to animation.
#
# Start by setting your lights to the included initial configuration (your puzzle input). A # means "on", and a . means "off".
#
# Then, animate your grid in steps, where each step decides the next configuration based on the current one. Each light's next state (either on or off) depends on its current state and the current states of the eight lights adjacent to it (including diagonals). Lights on the edge of the grid might have fewer than eight neighbors; the missing ones always count as "off".
#
# For example, in a simplified 6x6 grid, the light marked A has the neighbors numbered 1 through 8, and the light marked B, which is on an edge, only has the neighbors marked 1 through 5:
#
# 1B5...
# 234...
# ......
# ..123.
# ..8A4.
# ..765.
# The state a light should have next is based on its current state (on or off) plus the number of neighbors that are on:
#
# A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
# A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
# All of the lights update simultaneously; they all consider the same current state before moving to the next.
#
# Here's a few steps from an example configuration of another 6x6 grid:
#
# Initial state:
# .#.#.#
# ...##.
# #....#
# ..#...
# #.#..#
# ####..
#
# After 1 step:
# ..##..
# ..##.#
# ...##.
# ......
# #.....
# #.##..
#
# After 2 steps:
# ..###.
# ......
# ..###.
# ......
# .#....
# .#....
#
# After 3 steps:
# ...#..
# ......
# ...#..
# ..##..
# ......
# ......
#
# After 4 steps:
# ......
# ......
# ..##..
# ..##..
# ......
# ......
# After 4 steps, this example has four lights on.
#
# In your grid of 100x100 lights, given your initial configuration, how many lights are on after 100 steps?

def start_lights
  @lights ||= STDIN.read.split("\n").map{|line| line.chars}
end

def neighbours(lights, x, y)
  boundary = lights[x].count-1
  neighbours = []
  neighbours << lights[x-1][y]   if x > 0
  neighbours << lights[x-1][y-1] if x > 0 && y > 0
  neighbours << lights[x][y-1]   if y > 0
  neighbours << lights[x+1][y]   if x < boundary
  neighbours << lights[x+1][y+1] if x < boundary && y < boundary
  neighbours << lights[x][y+1]   if y < boundary
  neighbours << lights[x-1][y+1] if x > 0 && y < boundary
  neighbours << lights[x+1][y-1] if y > 0 && x < boundary
  neighbours
end

def count_on(state)
  state.map{|r| r.select{|i| i == '#'}.count}.reduce(:+)
end

def next_state(lights)
  next_s = lights.map{|row| row.dup}
  for x in 0..99
    for y in 0..99
      yield(lights, next_s, x, y)
    end
  end
  next_s
end


if $0 == __FILE__
  state = start_lights

  100.times do
    state = next_state(state) do |lights, next_s, x, y|
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
end
