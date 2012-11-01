#!/usr/bin/env ruby

# help at: https://github.com/kianryan/RubyGameLife

require 'curses'

class Grid
  # NOTE: Using 1 to represent living cell, -1 to represent dead cell
  attr_accessor :grid
  attr_reader :x, :y

  def initialize(x, y, living_cells=[])
    @x = x
    @y = y
    coordinates = (1..x).to_a.product( (1..y).to_a )
    grid = coordinates.map { |xy| [xy, -1] }
    @grid = Hash[grid]
    self.toggle_cells(living_cells)
  end

  def [](x, y)
    @grid[ [x,y] ]
  end

  def toggle(x, y)
    @grid[ [x,y] ] *= -1
  end

  def toggle_cells(cells)
    cells.each do |cell|
      self.toggle(cell[0], cell[1])
    end
  end

  def next_generation
    #
    # Rules for cell life/death as follows, where C is the current cell's state
    # and N is the number of living neighbor cells
    #
    #  C   N                   new C
    #  1   0,1             ->  -1  (Lonely)
    #  1   4,5,6,7,8       ->  -1  (Overcrowded)
    #  1   2,3             ->   1  (Lives)
    # -1   3               ->   1  (It takes three to give birth!)
    # -1   0,1,2,4,5,6,7,8 ->  -1  (Barren)
    #
    cells_to_toggle = []
    (1..@y).each do |y|
      (1..@x).each do |x|
        living = self.living?(x, y)
        living_neighbors = self.count_living_neighbors(x, y)
        if (living && (living_neighbors < 2 || living_neighbors > 3)) ||
             (!living && living_neighbors == 3)
          cells_to_toggle << [x, y]
        end
      end
    end
    self.toggle_cells(cells_to_toggle)
  end

  def living?(x, y)
    self[x, y] == 1
  end

  def count_living_neighbors(x, y)
    living_neighbors = 0
    
    # check row above
    if y > 0
      if x > 0
        living_neighbors += 1 if self.living?(x-1, y-1)
      end
      living_neighbors += 1 if self.living?(x, y-1)
      if x < @x
        living_neighbors += 1 if self.living?(x+1, y-1)
      end
    end

    # check same row
    if x > 0
      living_neighbors += 1 if self.living?(x-1, y)
    end
    if x < @x
      living_neighbors += 1 if self.living?(x+1, y)
    end

    # check row below
    if y < @y
      if x > 0
        living_neighbors += 1 if self.living?(x-1, y+1)
      end
      living_neighbors += 1 if self.living?(x, y+1)
      if x < @x
        living_neighbors += 1 if self.living?(x+1, y+1)
      end
    end

    living_neighbors
  end

  def print_grid(window=false)
    colors = {1 => '@', -1 => ' '}
    if window
      (1..@y).each do |y|
        (1..@x).each do |x|
          window.setpos(y-1, (x*2)-1)
          window.addstr( colors[ self[x,y] ] )
          window.setpos(y-1, x*2)
          window.addstr(' ')
        end
      end
      window.refresh
    else
      self.print_border
      (1..@y).each do |y|
        print '|'
        (1..@x).each do |x|
          print colors[ self[x,y] ]
          print ' '
        end
        puts '|'
      end
      self.print_border
    end
  end

  def print_border
    puts "+#{Array.new(@x, '-').join}+"
  end
end


class Game
  attr_accessor :grid, :window, :generations

  def initialize(grid, window=false, generations=false)
    @grid = grid
    @window = window
    @generations = generations
    self.show_generation(0)
  end

  def show_generation(n=false)
    if !@window && n
      puts "\n\n===== GENERATION #{n} ====="
    end
    @grid.print_grid(@window)
  end

  def run
    if generations
      (1..@generations).each do |n|
        @grid.next_generation
        self.show_generation(n)
      end
    else
      if @window
        while @window.getch != 'q'[0]
          @grid.next_generation
          self.show_generation
          sleep 0.25
        end
      else
        @grid.next_generation
        self.show_generation
      end
    end
  end
end


if __FILE__ == $0
  begin
    Curses.init_screen
    Curses.curs_set(0)
    Curses.start_color
    Curses.init_pair(Curses::COLOR_BLUE, Curses::COLOR_BLUE, Curses::COLOR_BLACK)
    Curses.init_pair(Curses::COLOR_WHITE, Curses::COLOR_WHITE, Curses::COLOR_BLACK)

    ##
    ## blinker
    ##
    #setup = [
    #  [1,2], [2,2], [3,2]
    #]
    #width, height = [6, 6]

    ##
    ## toad
    ##
    #setup = [
    #  [2,2], [3,2], [4,2], [1,3], [2,3], [3,3]
    #]
    #width, height = [8, 8]

    ##
    ## beacon
    ##
    #setup = [
    #  [2,2], [3,2], [2,3], [5,4], [4,5], [5,5]
    #]
    #width, height = [12, 12]

    ##
    ## glider
    ##
    #setup = [
    #  [2,2], [3,3], [4,3], [2,4], [3,4]
    #]
    #width, height = [40, 40]
    
    ##
    ## pulsar
    ##
    setup = [
      [4,2], [5,2], [6,2], [10,2], [11,2], [12,2],
      [2,4], [7,4], [9,4], [14,4],
      [2,5], [7,5], [9,5], [14,5],
      [2,6], [7,6], [9,6], [14,6],
      [4,7], [5,7], [6,7], [10,7], [11,7], [12,7],
      [4,9], [5,9], [6,9], [10,9], [11,9], [12,9],
      [2,10], [7,10], [9,10], [14,10],
      [2,11], [7,11], [9,11], [14,11],
      [2,12], [7,12], [9,12], [14,12],
      [4,14], [5,14], [6,14], [10,14], [11,14], [12,14],
    ]
    width, height= [30, 30]

    #
    # run the game
    #
    win = Curses::Window.new(height, width, 0, 0)
    grid = Grid.new(width, height, setup)
    game = Game.new(grid, win)
    win.nodelay = true
    game.run
  ensure
    win.close
    Curses.close_screen
  end
end
