#!/usr/bin/env ruby

# --- Day 12: JSAbacusFramework.io ---
#
# --- Part Two ---
#
# Uh oh - the Accounting-Elves have realized that they double-counted everything red.
#
# Ignore any object (and all of its children) which has any property with the value "red". Do this only for objects ({...}), not arrays ([...]).
#
# [1,2,3] still has a sum of 6.
# [1,{"c":"red","b":2},3] now has a sum of 4, because the middle object is ignored.
# {"d":"red","e":[1,2,3,4],"f":5} now has a sum of 0, because the entire structure is ignored.
# [1,"red",5] has a sum of 6, because "red" in an array has no effect.

require 'json'

def t(input)
  case input.class.to_s
  when 'Array'
    input.map {|el| t(el)}.reduce(:+)
  when 'Hash'
    input.values.include?('red') ? 0 : input.map {|_,v| t(v)}.reduce(:+)
  when 'Fixnum'
    input
  else
    0
  end
end

p t(JSON.parse(STDIN.read))
