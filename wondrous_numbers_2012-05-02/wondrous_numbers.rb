#!/usr/bin/env ruby

class Integer
  def even?
    return self % 2 == 0
  end

  def odd?
    return self % 2 == 1
  end
end

def generate_wondrous_number_sequence(n)
  s = [n]
  until n == 1 do
    s.push( n = n.even? ? (n/2) : ((n*3)+1) )
  end
  return s
end

if __FILE__ == $0
  ARGF.each do |line|
    puts generate_wondrous_number_sequence(line.to_i).to_s
  end
end
