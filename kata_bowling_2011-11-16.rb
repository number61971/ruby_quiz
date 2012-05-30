#!/usr/bin/env ruby

#
# Exercise from http://codingdojo.org/cgi-bin/wiki.pl?KataBowling
#

class BowlingGame
  def initialize(rolls_str)
    @rolls = rolls_str.split(//)
  end

  def convert_notation(roll, roll_prev)
    if roll == "X"
      10
    elsif roll == "/"
      10 - roll_prev.to_i
    elsif roll == "-"
      0
    else
      roll.to_i
    end
  end

  def score
    s = 0       # running score total
    r_prev = 0  # previous roll, for calculating score in a frame with a spare
    frame = 1   # the frame count
    r_count = 0 # the number of rolls in a frame

    rolls = @rolls.dup
    while rolls.length > 0
      r = rolls.shift
      r_count += 1
      s += self.convert_notation(r, r_prev)

      if r == "X"
       # strike: add the next two rolls to the score, unless it's the 10th frame
        r_count = 0
        if frame < 10
          frame += 1
          n_prev = 0
          rolls[0..1].each { |n|
            s += self.convert_notation(n, n_prev)
            n_prev = n
          }
        end

      elsif r == "/"
        # spare: add the next roll to the score, unless it's the 10th frame
        r_count = 0
        if frame < 10
          frame += 1
          rolls[0..0].each{ |n|
            s += self.convert_notation(n, r_prev)
          }
        end

      elsif r_count == 2
        if frame < 10
          frame += 1
        end
        r_count = 0

      end
      r_prev = r
    end

    s

  end

end

#
# RUN PROGRAM
#

example_rolls = [
  "XXXXXXXXXXXX",
  "9-9-9-9-9-9-9-9-9-9-",
  "5/5/5/5/5/5/5/5/5/5/5"
]

for r in example_rolls
  bg = BowlingGame.new(r)
  puts "scoreline \"#{r}: #{bg.score} points"
end
