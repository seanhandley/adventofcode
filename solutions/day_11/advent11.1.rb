#!/usr/bin/env ruby

# --- Day 11: Corporate Policy ---
#
# Santa's previous password expired, and he needs help choosing a new one.
#
# To help him remember his new password after the old one expires, Santa has devised a method of coming up with a password based on the previous one. Corporate policy dictates that passwords must be exactly eight lowercase letters (for security reasons), so he finds his new password by incrementing his old password string repeatedly until it is valid.
#
# Incrementing is just like counting with numbers: xx, xy, xz, ya, yb, and so on. Increase the rightmost letter one step; if it was z, it wraps around to a, and repeat with the next letter to the left until one doesn't wrap around.
#
# Unfortunately for Santa, a new Security-Elf recently started, and he has imposed some additional password requirements:
#
# Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
# Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
# Passwords must contain at least two pairs of letters, like aa, bb, or zz.
# For example:
#
# hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
# abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
# abbcegjk fails the third requirement, because it only has one double letter (bb).
# The next password after abcdefgh is abcdffaa.
# The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.
#
# Given Santa's current password (your puzzle input), what should his next password be?

@password = STDIN.gets.strip

def straights
  return @straights if @straights
  letters = ('a'..'z').to_a
  @straights = (0...24).map do |i|
    "#{letters[i]}#{letters[i+1]}#{letters[i+2]}"
  end
end

def two_pairs?(password)
  pairs_found = 0
  password.chars.chunk{|i| i}.each do |char, occurences|
    pairs_found += 1 if occurences.count == 2
    return true if pairs_found == 2
  end
  false
end

def contains_straight?(password)
  straights.each do |straight|
    return true if password.include?(straight)
  end
  false
end

def valid?(password)
  ['i','o','l'].each do |forbidden|
    return false if password.include?(forbidden)
  end
  return false unless contains_straight?(password)
  return false unless two_pairs?(password)
  true
end

def next_byte(byte)
  byte = (byte += 1) % 123
  byte < 97 ? byte += 97 : byte
end

def next_password(password)
  carry_over = true
  password.reverse.each_byte.map do |byte|
    if carry_over
      ret = next_byte(byte)
      carry_over = ret < byte ? true : false
      ret
    else
      byte
    end
  end.reverse.pack('c*')
end

def find_new_password(password)
  next until (@password = next_password(@password)) && valid?(@password)
  @password
end

if $0 == __FILE__
  puts find_new_password(@password)
end
