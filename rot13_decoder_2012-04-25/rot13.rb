#!/usr/bin/env ruby

def rot13_transform(s)
  out = ''
  for c in s.upcase.each_char
    if c.ord >= 'A'.ord && c.ord <= 'Z'.ord
      c = ((c.ord + 13) > 'Z'.ord) ? (c.ord - 13).chr : (c.ord + 13).chr
    end
    out << c
  end
  return out
end

if __FILE__ == $0
  ARGF.each do |line|
    puts rot13_transform(line)
  end
end
