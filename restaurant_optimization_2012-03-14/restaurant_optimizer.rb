#!/usr/bin/env ruby

require 'csv'
require 'set'

class Restaurant
  attr_accessor :id, :menu

  def initialize(id)
    @id = id.to_i
    @menu = {}
  end

  def add_menu_item(price, items)
    items = Set.new( items.each{ |item| item.strip! } )
    @menu[items] = price.to_f
  end

  def menu_items
    items = @menu.keys.map{ |key| key.to_a }
    Set.new(items.flatten)
  end

  def lowest_price(items)
    prices = []
    for menu_items in @menu.keys
      if items.subset?(menu_items)
        prices.push(@menu[menu_items])
      end
    end
    
    price = 0.0
    for item in items
      item = Set.new([item])
      for menu_items in @menu.keys
        if item.subset?(menu_items)
          price += @menu[menu_items]
        end
      end
    end
    prices.push(price)

    prices.sort!
    prices[0]
  end
end


if __FILE__ == $0
  #
  # Convert input data into usable form
  #
  restaurants_all = {}
  CSV.foreach(ARGV[0]) do |row|
    restaurant_id = row[0].to_i
    restaurant = restaurants_all.fetch(restaurant_id, Restaurant.new(restaurant_id))
    restaurant.add_menu_item(row[1], row[2, row.length])
    restaurants_all[restaurant_id] = restaurant
  end

  #
  # Find all restaurants that offer the desired items
  #
  requested_items = Set.new( ARGV[1, ARGV.length] )
  valid_restaurants = []
  for id, restaurant in restaurants_all
    if requested_items.subset?(restaurant.menu_items)
      valid_restaurants.push(restaurant)
    end
  end

  #
  # Find the lowest price among the restaurants
  #
  if valid_restaurants.length == 0
    puts "No restaurant offers #{requested_items.to_a.join(', ')}."
  else
    prices = valid_restaurants.map{ |r| [r.lowest_price(requested_items), r.id] }
    prices.sort!
    price = "%.02f" % prices[0][0]
    restaurant_id = prices[0][1]
    puts "Best price is $#{price} at restaurant #{restaurant_id}."
  end
end
