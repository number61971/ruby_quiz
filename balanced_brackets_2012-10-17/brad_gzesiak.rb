f = '[[[]]]'
f.gsub! /\[\]/, '' until f !~ /\[\]/
puts f == ''
