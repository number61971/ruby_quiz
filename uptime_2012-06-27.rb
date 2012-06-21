#!/usr/bin/env ruby

uptime = `uptime`.gsub(/^[^\s]+\s+[^\s]+\s+(\d+:\d+).+$/, '\1').strip
hours, minutes = uptime.split(/:/)
puts "System has been up and running for #{hours} hours and #{minutes} minutes."
