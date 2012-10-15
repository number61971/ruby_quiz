#!/usr/bin/env ruby

def factorial_recursive(n)
  if n == 0
    return 1
  else
    return n * factorial(n-1)
  end
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

#####

def factorial_y(f)
  lambda do |n|
    if n == 0
      return 1
    else
      return n * f.call(n-1)
    end
  end
end

def fibonacci_y(f)
  lambda do |n|
    if n == 0
      return 0
    elsif n == 1
      return 1
    else
      return f.call(n-1) + f.call(n-2)
    end
  end
end

def y(f)
  lambda do |x|
    x.call(x)
  end
end

#####

def factorial(n)
  factorial_recursive(n)
  #y(factorial_y(n))
end

def fibonacci(n)
  fibonacci_recursive(n)
  #y(fibonacci_y(n))
end


if __FILE__ == $0
  fac = factorial_y(lambda {|n| n+1})
  puts fac.call(3)
end
