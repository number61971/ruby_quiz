#!/usr/bin/env ruby

require 'set'

class Range
  def to_regexp
    # NOTE: stupid simple ... ugly :(
    a = self.to_a.map {|i| "\\b#{i.to_s}\\b"}
    Regexp.new(a.join("|"))

    # TODO: analyze each range and use character classes
    # e.g., 90..110 => \b(9\d|1[0-1]\d)\b
    # ?? programmatically easier to use [0-9] instead of \d ??
  end
end

class Regexp
  def self.build(*args)
    # create unique set of integers from incoming args of integers and ranges
    # (and ignore anything not an integer or range of integers)
    set = Set.new
    for arg in args do
      if arg.respond_to?(:to_i)
        set.add(arg.to_i)
      elsif arg.respond_to?(:include?) && arg.first.respond_to?(:to_i)
        for i in arg do
          set.add(i.to_i)
        end
      end
    end

    # break into sets of ranges and individual integers
    sets = set.divide {|a,b| (a - b).abs == 1}
    ranges = []
    for s in sets do
      array = s.to_a.sort
      if array.first == array.last
        ranges.push(array.first)
      else
        ranges.push(Range.new(array.first, array.last))
      end
    end
    puts ranges

    # build regex string
    re = []
    for r in ranges do
      if r.respond_to?(:to_i)
        # convert integers into regexes
        re.push("\\b#{r.to_s}\\b")
      else
        # convert ranges into regexes
        re.push(r.to_regexp.to_s)
      end
    end

    # return the Regexp instance
    self.new(re.join("|"))
  end
end


if __FILE__ == $0
  re = Regexp.build(1,2,3,4,5,3,2,4..8,6..10,56,98..110,2345,9998..10020)
  puts re.inspect
  puts re.match("blah 23 blah").inspect
  puts re.match("blah 5 blah").inspect
end
