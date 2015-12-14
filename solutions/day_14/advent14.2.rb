#!/usr/bin/env ruby

# --- Day 14: Reindeer Olympics ---
#
# --- Part Two ---
#
# Seeing how reindeer move in bursts, Santa decides he's not pleased with the old scoring system.
#
# Instead, at the end of each second, he awards one point to the reindeer currently in the lead. (If there are multiple reindeer tied for the lead, they each get one point.) He keeps the traditional 2503 second time limit, of course, as doing otherwise would be entirely ridiculous.
#
# Given the example reindeer from above, after the first second, Dancer is in the lead and gets one point. He stays in the lead until several seconds into Comet's second burst: after the 140th second, Comet pulls into the lead and gets his first point. Of course, since Dancer had been in the lead for the 139 seconds before that, he has accumulated 139 points by the 140th second.
#
# After the 1000th second, Dancer has accumulated 689 points, while poor Comet, our old champion, only has 312. So, with the new scoring system, Dancer would win (if the race ended at 1000 seconds).
#
# Again given the descriptions of each reindeer (in your puzzle input), after exactly 2503 seconds, how many points does the winning reindeer have?

reindeer = STDIN.read.split("\n")

@scores = reindeer.inject({}) do |h,r|
  name = r.scan(/^\w+/).flatten[0]
  speed = r.scan(/(\d+) km/).flatten[0].to_i
  max_duration = r.scan(/for (\d+) seconds/).flatten[0].to_i
  rest_for = r.scan(/(\d+) seconds.$/).flatten[0].to_i
  h[name] = {score: 0, speed: speed, max_duration: max_duration, rest_for: rest_for,
             state: {distance: 0, duration: 0, go: true}}
  h
end

for i in 0...2503
  @scores.each do |name, data|
    if data[:state][:go]
      data[:state][:distance] += data[:speed]
      data[:state][:duration] += 1
      if data[:state][:duration] == data[:max_duration]
        data[:state][:go] = false
        data[:state][:duration] = 0
      end
    else
      data[:state][:duration] += 1
      if data[:state][:duration] == data[:rest_for]
        data[:state][:go] = true
        data[:state][:duration] = 0
      end
    end
  end
  max_distance = @scores.map{|_, data| data[:state][:distance]}.max
  winning_reindeer = @scores.select{|name, data| data[:state][:distance] == max_distance}
  winning_reindeer.each{|_, data| data[:score] += 1}
end

p @scores.max{|a, b| a[1][:score] <=> b[1][:score]}[1][:score]
