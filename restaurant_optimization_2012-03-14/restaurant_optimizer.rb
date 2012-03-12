#!/usr/bin/env ruby

require 'csv'
require 'set'

#
# Convert input data into usable form
#
restaurants_all = {}
CSV.foreach(ARGV[0]) do |row|
  restaurant_id = row[0].to_i
  items_price = row[1].to_f
  items = Set.new( row[2, row.length].each{ |item| item.strip! } )
  restaurant = restaurants_all.fetch(restaurant_id, {})
  restaurant[items] = items_price
  restaurants_all[restaurant_id] = restaurant
end

#
# Find all restaurants that offer the desired items
#
items = Set.new( ARGV[1, ARGV.length] )
puts items.inspect
restaurants = []
for key, value in restaurants_all
  puts key.inspect
  puts value.inspect
  value_set = Set.new(value.keys)
  puts value_set.inspect
  puts items.subset?(value_set)
end
#restaurants_all.each{ |restaurant|
#  puts restaurant.keys
#  puts items
#  if Set.new(restaurant.keys).subset?(items)
#    #puts restaurant
#  end
#}
