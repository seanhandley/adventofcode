#!/usr/bin/env ruby

# --- Day 6: Probably a Fire Hazard ---
#
# --- Part Two ---
#
# You just finish implementing your winning light pattern when you realize you mistranslated Santa's message from Ancient Nordic Elvish.
#
# The light grid you bought actually has individual brightness controls; each light can have a brightness of zero or more. The lights all start at zero.
#
# The phrase turn on actually means that you should increase the brightness of those lights by 1.
# The phrase turn off actually means that you should decrease the brightness of those lights by 1, to a minimum of zero.
# The phrase toggle actually means that you should increase the brightness of those lights by 2.
#
# For example:
#
# turn on 0,0 through 0,0 would increase the total brightness by 1.
# toggle 0,0 through 999,999 would increase the total brightness by 2000000.
#
# What is the total brightness of all lights combined after following Santa's instructions?

require_relative "christmas_lights"

p let_there_be_light! 'turn on'      => -> (x) {          x + 1 },
                      'turn off'     => -> (x) { [x - 1, 0].max },
                      'toggle'       => -> (x) {          x + 2 },
                      'instructions' => STDIN.read.split("\n")
