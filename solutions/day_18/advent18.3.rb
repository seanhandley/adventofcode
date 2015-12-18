#!/usr/bin/env ruby

# --- Day 18: Like a GIF For Your Yard ---

# Part 3: Animated GIF

require 'rmagick'
require_relative 'advent18.1'

def draw_state(state)
  image = Magick::Image.new(100,100) { self.background_color = "black" }
  state.each_with_index do |row, x|
    row.each_with_index do |el, y|
      el == '#' ? image.pixel_color(x, y, x % 2 == 0 ? "#FF0000" : "#FF7700") : image.pixel_color(x, y, "#000000")
    end
  end
  image
end

state = start_lights
gif = Magick::ImageList.new
1000.times do
  gif << draw_state(state); state = next_state(state) do |lights, next_s, x, y|
    if lights[x][y] == '.'
      if neighbours(lights, x, y).select{|n| n == '#'}.count == 3
        next_s[x][y] = '#'
      end
    else
      on = neighbours(lights, x, y).select{|n| n == '#'}.count
      next_s[x][y] = '.' unless [2,3].include?(on)
    end
  end
  gif.change_geometry!('300x300') { |cols, rows, img|
    img.resize!(cols, rows)
  }
end

gif.write("./life.gif")
