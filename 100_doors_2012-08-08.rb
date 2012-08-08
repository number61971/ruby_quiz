#!/usr/bin/env ruby

states = { 0 => 'closed', 1 => 'open' }

doors = Array.new(100, 0)
(1..100).each do |pass|
  doors.each_with_index do |door,i|
    if (i + 1) % pass == 0
      doors[i] = (doors[i] + 1) % 2
    end
  end
end

doors.each_with_index do |door,i|
  puts "Door ##{i+1}: #{states[door]}"
end
