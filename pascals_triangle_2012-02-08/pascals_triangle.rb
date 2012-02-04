#!/usr/bin/env ruby

class NegativeFactorialError < StandardError
end

class Integer
  def factorial
    if self < 0
      raise NegativeFactorialError.new("Cannot calculate the factorial of a negative integer")
    end
    result = 1
    (1..self).each do |i|
      result *= i
    end
    result
  end
end

class InvalidPascalTriangleError < StandardError
end

class PascalTriangle
  def calculate(row, position)
    row, position = self.validate(row, position)

    # formula for calculating a single cell in Pascal's triangle lifted from http://en.wikipedia.org/wiki/Pascal%27s_triangle
    row.factorial / (position.factorial * (row - position).factorial)
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

  triangle = PascalTriangle.new
  puts "\nThe value of position #{position} in row #{row} is: #{triangle.calculate(row, position)}."
end
