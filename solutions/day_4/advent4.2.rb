#!/usr/bin/env ruby

# Now find one that starts with six zeroes.

require 'digest/md5'

key = STDIN.gets

for i in 0..10_000_000_000
  hash = Digest::MD5.hexdigest(key + i.to_s)
  if hash =~ /^000000/
    p i
    break
  end
end