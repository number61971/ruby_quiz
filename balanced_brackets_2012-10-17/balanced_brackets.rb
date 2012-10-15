#!/usr/bin/env ruby

def balance_checker(s)
  brackets = []
  num_brackets = s.length
  (1..num_brackets).each do |n|
    bracket = s.slice!(0)
    if bracket == '['
      brackets << bracket
    else
      result = brackets.pop
      return false if result == nil
    end
  end

  if brackets.length > 0
    return false
  else
    return true
  end
end
