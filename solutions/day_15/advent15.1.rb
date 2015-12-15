#!/usr/bin/env ruby

# --- Day 15: Science for Hungry People ---
#
# Today, you set out on the task of perfecting your milk-dunking cookie recipe. All you have to do is find the right balance of ingredients.
#
# Your recipe leaves room for exactly 100 teaspoons of ingredients. You make a list of the remaining ingredients you could use to finish the recipe (your puzzle input) and their properties per teaspoon:
#
# capacity (how well it helps the cookie absorb milk)
# durability (how well it keeps the cookie intact when full of milk)
# flavor (how tasty it makes the cookie)
# texture (how it improves the feel of the cookie)
# calories (how many calories it adds to the cookie)
# You can only measure ingredients in whole-teaspoon amounts accurately, and you have to be accurate so you can reproduce your results in the future. The total score of a cookie can be found by adding up each of the properties (negative totals become 0) and then multiplying together everything except calories.
#
# For instance, suppose you have these two ingredients:
#
# Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
# Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
# Then, choosing to use 44 teaspoons of butterscotch and 56 teaspoons of cinnamon (because the amounts of each ingredient must add up to 100) would result in a cookie with the following properties:
#
# A capacity of 44*-1 + 56*2 = 68
# A durability of 44*-2 + 56*3 = 80
# A flavor of 44*6 + 56*-2 = 152
# A texture of 44*3 + 56*-1 = 76
# Multiplying these together (68 * 80 * 152 * 76, ignoring calories for now) results in a total score of 62842880, which happens to be the best score possible given these ingredients. If any properties had produced a negative total, it would have instead become zero, causing the whole score to multiply to zero.
#
# Given the ingredients in your kitchen and their properties, what is the total score of the highest-scoring cookie you can make?

require_relative 'fixnum'

def ingredients
  @ingredients ||= STDIN.read.split("\n").map do |entry|
    name, rest = entry.split(":")
    Hash[rest.split(",").map {|params| [params.strip.split[0], params.strip.split[1].to_i]}.push(['name', name])]
  end
end

def score(input)
  score = ["capacity","durability","flavor","texture"].map do |prop|
    score = input.map do |amount, properties|
      properties[prop] * amount
    end.reduce(:+)
    [score, 0].max
  end.reduce(:*)
  calories = input.map do |amount, properties|
    properties['calories'] * amount
  end.reduce(:+)
  {'score' => score, 'calories' => calories, 'recipe' => Hash[input.map{|a, p| [p['name'], a]}]}
end

def combos(size)
  @combos ||= size.partition(ingredients.count).map do |i|
    i.push(0) until i.count == ingredients.count
    i.permutation.to_a.uniq
  end
end

def scores
  @scores ||= combos(spoons).map do |combo|
    combo.map do |perm|
      score(ingredients.count.times.each_with_index.map do |_, i|
        [perm[i], ingredients[i]]
      end)
    end
  end.flatten
end

def spoons
  100
end

if $0 == __FILE__
  p scores.max{|i,j| i['score'] <=> j['score']}
end
