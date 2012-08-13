#!/usr/bin/env ruby

class Grid
  # NOTE: Using 1 to represent black, -1 to represent white
  attr_accessor :grid
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    coordinates = (1..x).to_a.product( (1..y).to_a )
    grid = coordinates.map { |xy| [xy, 1] }
    @grid = Hash[grid]
  end

  def [](x, y)
    @grid[ [x,y] ]
  end

  def toggle(x, y)
    @grid[ [x,y] ] *= -1
  end

  def print_grid
    colors = {1 => ' ', -1 => '#'}
    self.print_border
    (1..@y).each do |y|
      print '|'
      (1..@x).each do |x|
        print colors[ self[x,y] ]
      end
      puts '|'
    end
    self.print_border
  end

  def print_border
    puts "+#{Array.new(@x, '-').join}+"
  end
end


Directions = ['north','east','south','west']

class Ant
  attr_accessor :direction, :grid, :x, :y

  def initialize(grid)
    # start facing a random direction, on a central grid spot
    @direction = Directions.shuffle[0]
    @grid = grid
    @x = grid.x/2
    @y = grid.y/2
  end

  def position
    [@x, @y]
  end

  def turn_left!
    @direction = Directions[ Directions.index(@direction) - 1 ]
  end

  def turn_right!
    @direction = Directions[ (Directions.index(@direction) + 1) % 4 ]
  end

  def go_north!
    @y -= 1
  end

  def go_east!
    @x += 1
  end

  def go_south!
    @y += 1
  end

  def go_west!
    @x -= 1
  end

  def move!
    if @grid[@x, @y] == 1
      self.turn_right! # on a white square, turn right
    else
      self.turn_left! # on a black square, turn left
    end

    @grid.toggle(@x, @y) # toggle the square color

    self.send("go_#{@direction}!".to_sym) # go one square in new direction
  end
end


if __FILE__ == $0
  x = 100
  y = 100
  grid = Grid.new(x,y)
  ant = Ant.new(grid)
  while ant.x > 0 && ant.x <= x && ant.y > 0 && ant.y <= y do
    ant.move!
  end
  grid.print_grid
end
