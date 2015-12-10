#!/usr/bin/env ruby

# --- Day 9: All in a Single Night ---
#
# Every year, Santa manages to deliver all of his presents in a single night.
#
# This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?
#
# For example, given the following distances:
#
# London to Dublin = 464
# London to Belfast = 518
# Dublin to Belfast = 141
# The possible routes are therefore:
#
# Dublin -> London -> Belfast = 982
# London -> Dublin -> Belfast = 605
# London -> Belfast -> Dublin = 659
# Dublin -> Belfast -> London = 659
# Belfast -> Dublin -> London = 605
# Belfast -> London -> Dublin = 982
# The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.
#
# What is the distance of the shortest route?
@distances = STDIN.read.split("\n")

@locations = @distances.inject({}) do |location, distance|
  nodes, dist_val = distance.split(' = ')
  nodes.split(' to ').permutation.each do |a, b|
    location[a] ||= {'destinations' => {}}
    location[a]['destinations'][b] = dist_val.to_i
  end
  location
end

def journey_distances
  @locations.keys.permutation.collect do |ordering|
    (ordering.count - 1).times.each_with_index.map do |_, i|
      @locations[ordering[i]]['destinations'][ordering[i + 1]]
    end.reduce(:+)
  end.flatten
end

if $0 == __FILE__
  p journey_distances.min
end
