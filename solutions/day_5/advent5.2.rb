#!/usr/bin/env ruby

# Realizing the error of his ways, Santa has switched to a better model of determining whether a string is naughty or nice. None of the old rules apply, as they are all clearly ridiculous.

# Now, a nice string is one with all of the following properties:

# It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
# It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
# For example:

# qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that repeats with exactly one letter between them (zxz).
# xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.
# uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.
# ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair that appears twice.
# How many strings are nice under these new rules?

class String
  def equal_chunks(size)
    i = 0
    chunks = []
    (length-size+1).times do
      chunks << slice(i, size)
      i += 1 
    end
    chunks
  end
  def indexes(substring)
    found = []
    current_index = -1
    while current_index = index(substring, current_index+1)
      found << current_index
    end
    found
  end
end

class Array
  def has_one_index_pair_non_consecutive?
    return true if count > 2
    i = 0
    (count-1).times do
      return true if (self[i+1] - self[i]) > 1
      i += 1
    end
    false
  end
end

strings = STDIN.read.split("\n")

nice = strings.select do |string|
  string.equal_chunks(3).any? do |chunk|
    chunk.chars[0] == chunk.chars[2]
  end && string.equal_chunks(2).any? do |chunk|
    indexes = string.indexes(chunk)
    indexes.count >= 2 && indexes.has_one_index_pair_non_consecutive?
  end
end

p nice.count
