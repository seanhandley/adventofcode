#!/usr/bin/env ruby

# --- Day 16: Aunt Sue ---
#
# Your Aunt Sue has given you a wonderful gift, and you'd like to send her a thank you card. However, there's a small problem: she signed it "From, Aunt Sue".
#
# You have 500 Aunts named "Sue".
#
# So, to avoid sending the card to the wrong person, you need to figure out which Aunt Sue (which you conveniently number 1 to 500, for sanity) gave you the gift. You open the present and, as luck would have it, good ol' Aunt Sue got you a My First Crime Scene Analysis Machine! Just what you wanted. Or needed, as the case may be.
#
# The My First Crime Scene Analysis Machine (MFCSAM for short) can detect a few specific compounds in a given sample, as well as how many distinct kinds of those compounds there are. According to the instructions, these are what the MFCSAM can detect:
#
# children, by human DNA age analysis.
# cats. It doesn't differentiate individual breeds.
# Several seemingly random breeds of dog: samoyeds, pomeranians, akitas, and vizslas.
# goldfish. No other kinds of fish.
# trees, all in one group.
# cars, presumably by exhaust or gasoline or something.
# perfumes, which is handy, since many of your Aunts Sue wear a few kinds.
#
# In fact, many of your Aunts Sue have many of these. You put the wrapping from the gift into the MFCSAM. It beeps inquisitively at you a few times and then prints out a message on ticker tape:
#
# children: 3
# cats: 7
# samoyeds: 2
# pomeranians: 3
# akitas: 0
# vizslas: 0
# goldfish: 5
# trees: 3
# cars: 2
# perfumes: 1
#
# You make a list of the things you can remember about each Aunt Sue. Things missing from your list aren't zero - you simply don't remember the value.
#
# What is the number of the Sue that got you the gift?

class Sue < Hash
  def compatible?(other_sue, how)
    each_pair.all? do |k,v|
      other_sue[k] ? how.call(other_sue, k, v) : true
    end
  end
end

def sues
  @sues ||= STDIN.read.split("\n").each_with_index.map do |sue, i|
    _, props = sue.split(/\d+:/)
    props = props.strip.split(',').inject(Sue.new) do |acc, prop|
      k, v = prop.strip.split(':')
      acc[k.strip] = v.strip.to_i
      acc
    end
    props.merge('number' => i+1)
  end
end

def analysis
  Sue[
    'children' => 3, 'cats'     => 7, 'samoyeds' => 2, 'pomeranians' => 3,
    'akitas'   => 0, 'vizslas'  => 0, 'goldfish' => 5, 'trees'       => 3,
    'cars'     => 2, 'perfumes' => 1
  ]
end

def matched_sue(how)
  sues.select do |sue|
    analysis.compatible?(sue, how)
  end[0]['number']
end

if $0 == __FILE__
  p matched_sue -> (other_sue, k, v) { other_sue[k] == v }
end
