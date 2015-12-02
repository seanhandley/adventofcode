#!/usr/bin/env ruby

# The elves are also running low on ribbon. Ribbon is all the same width, so they only have to worry about the length they need to order, which they would again like to be exact.

# The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

# For example:

# A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.
# A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.
# How many total feet of ribbon should they order?

# Input: https://gist.githubusercontent.com/seanhandley/527678e3be0dd088687d/raw/78abea9db2d715df05af39f8c589d4ae9965533b/gistfile1.txt
input = STDIN.read.split("\n")
measurements = input.map{|i| i.split('x').map(&:to_i)}

measurements = measurements.map do |measurement|
  short_side_a, short_side_b = measurement.sort[0], measurement.sort[1]
  short_side_a * 2 + short_side_b * 2 + measurement.reduce(:*)
end

p measurements.reduce(:+)