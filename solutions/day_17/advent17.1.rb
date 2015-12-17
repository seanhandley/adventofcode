#!/usr/bin/env ruby

#--- Day 17: No Such Thing as Too Much ---
#
# The elves bought too much eggnog again - 150 liters this time. To fit it all into your refrigerator, you'll need to move it into smaller containers. You take an inventory of the capacities of the available containers.
#
# For example, suppose you have containers of size 20, 15, 10, 5, and 5 liters. If you need to store 25 liters, there are four ways to do it:
#
# 15 and 10
# 20 and 5 (the first 5)
# 20 and 5 (the second 5)
# 15, 5, and 5
#
# Filling all containers entirely, how many different combinations of containers can exactly fit all 150 liters of eggnog?

def eggnog_litres
  150
end

def containers
  @containers ||= STDIN.read.split("\n").map(&:to_i).sort
end

def solutions
  @solutions ||= (1..containers.count).map do |size|
    containers.combination(size).select do |combo|
      combo.reduce(:+) == eggnog_litres
    end
  end.reduce(:+)
end

if $0 == __FILE__
  p solutions.count
end
