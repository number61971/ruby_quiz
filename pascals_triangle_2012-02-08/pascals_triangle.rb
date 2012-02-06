#!/usr/bin/env ruby

class NegativeFactorialError < StandardError
end

class Integer
  def factorial
    if self < 0
      raise NegativeFactorialError.new("Cannot calculate the factorial of a negative integer")
    end
    result = 1
    (1..self).each { |i| result *= i }
    result
  end
end

class InvalidPascalTriangleError < StandardError
end

class PascalTriangle
  attr_reader :method

  def initialize(method)
    if ! ['calculate', 'fetch'].include?(method)
      raise InvalidPascalTriangleError.new("Valid methods are 'calculate' and 'fetch'")
    end
    @method = method
  end

  def calculate(row, position)
    row, position = self.validate(row, position)

    # formula for calculating a single cell in Pascal's triangle lifted from http://en.wikipedia.org/wiki/Pascal%27s_triangle
    row.factorial / (position.factorial * (row - position).factorial)
  end

  def fetch(row, position)
    # Doing it the hard way! Building enough rows of the triangle to fetch the desired value.
    row, position = self.validate(row, position)
    # but only if strictly necessary...
    if position == 0 || position == row
      return 1
    elsif position == 1 || position == (row - 1)
      return row
    end

    # now it's strictly necessary...
    # starting the build from the 3rd row...
    row_curr = [1, 1]
    (2..row).each do |row|
      row_prev = row_curr
      row_curr = []
      (0..row).each do |col|
        if col == 0 || col == row
          row_curr.push(1)
        #elsif col == 1 || col == (row-1)
        #  row_curr.push(row)
        else
          row_curr.push( row_prev[col-1] + row_prev[col] )
        end
      end
    end

    row_curr[position]
  end

  def validate(row, position)
    begin
      row = Integer(row)
    rescue
      raise ArgumentError.new("'#{row}' is not an integer.")
    end

    begin
      position = Integer(position)
    rescue
      raise ArgumentError.new("'#{position}' is not an integer.")
    end

    if position > row || row < 1 || position < 1
      raise InvalidPascalTriangleError.new("Position #{position} does not exist in row #{row} of Pascal's triangle.")
    end
    [row - 1, position - 1]
  end
end

def prompt(*args)
  print(*args)
  gets.strip
end


if __FILE__ == $0
  require 'optparse'
  options = {:method => 'calculate'} # default
  optparse = OptionParser.new do |opts|
    opts.banner = "Usage: ruby pascals_triangle.rb [-c|-f]"
    opts.on('-h', '--help', 'Display this screen') do
      puts opts
      exit
    end
    opts.on('-c', 'Calculate the desired value using combinatorial formula (default behavior)') do
      options[:method] = 'calculate'
    end
    opts.on('-f', 'Fetch the desired value by building each triangle row sequentially') do
      options[:method] = 'fetch'
    end
  end
  
  optparse.parse!
  triangle = PascalTriangle.new(options[:method])

  puts "\n== Pascal's Triangle Cell Calculator ==\n\n"

  begin
    row = Integer(prompt('Enter a row number in the triangle: '))
  rescue
    raise ArgumentError.new("'#{row}' is not an integer.")
  end

  begin
    position = Integer(prompt("Enter a position in row #{row}: "))
  rescue
    raise ArgumentError.new("'#{position}' is not an integer.")
  end

  puts "\nThe value of position #{position} in row #{row} is: #{triangle.send(triangle.method, row, position)}."
end
