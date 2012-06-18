#!/usr/bin/env ruby

#
# recursive
#
def chop(int, array, idx=0)
  if array.length == 0 || int < array[0] || int > array[-1]
    return -1
  elsif array.length == 1
    return idx
  end

  midpoint = (array.length/2).to_i
  top = array[0..(midpoint-1)]
  if int <= top[-1]
    return chop(int, top, idx)
  else
    bottom = array[midpoint..array.length]
    return chop(int, bottom, (idx + top.length))
  end
end

if __FILE__ == $0
  puts chop(5, [1,3,5])
end
