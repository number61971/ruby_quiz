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

#
# looping
#
%Q(
def chop(int, array)
  if array.length == 0 || int < array[0] || int > array[-1]
    return -1
  end

  idx = 0
  while array.length > 0 && int >= array[0] && int <= array[-1]
    # the integer hasn't yet been found, chop off the top half
    midpoint = (array.length/2).to_i
    top = array[0..(midpoint-1)]
    if int > top[-1]
      # the integer is in the bottom half of the array
      array = array[midpoint..array.length]
      idx += top.length
    elsif int == top[-1]
      # the integer has been found, and the array is 1 or 2 elements in length
      if top.length > 1
        idx += top.length - 1
      end
      return idx
    else
      # the integer is somewhere in the top half
      array = top
    end
  end

  # if loop wasn't entered, the desired integer wasn't present in array
  return -1
end
)
