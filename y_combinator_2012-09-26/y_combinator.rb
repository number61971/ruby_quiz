#!/usr/bin/env ruby

def factorial_recursive(n)
  if n == 0
    return 1
  else
    return n * factorial(n-1)
  end
end

def fibonacci_y(n)
end


def fibonacci_recursive(n)
  if n == 0
    return 0
  elsif n == 1
    return 1
  else
    return fibonacci(n-1) + fibonacci(n-2)
  end
end

def fibonacci_y(n)
end

#####

def factorial(n)
  factorial_recursive(n)
  #fatorial_y(n)
end

def fibonacci(n)
  fibonacci_recursive(n)
  #fibonacci_y(n)
end
