#!/usr/bin/env ruby

# --- Day 21: RPG Simulator 20XX ---
#
# --- Part Two ---
#
# Turns out the shopkeeper is working with the boss, and can persuade you to buy whatever items he wants. The other rules still apply, and he still only has one of each item.
#
# What is the most amount of gold you can spend and still lose the fight?

require_relative 'advent21.1'

costs = []

shop[:weapons].each do |weapon|
  shop[:armor].each do |armor|
    shop[:rings].permutation(2).each do |rings|

      my_damage = weapon[:damage] + rings.map{|r| r[:damage]}.reduce(:+)
      my_armor = armor[:armor] + rings.map{|r| r[:armor]}.reduce(:+)
      cost = [weapon, armor, rings].flatten.map{|i| i[:cost]}.reduce(:+)

      me = Player.new(100, my_armor, my_damage)

      unless fight(me, boss)
        costs << cost
      end
    end
  end
end

p costs.max
