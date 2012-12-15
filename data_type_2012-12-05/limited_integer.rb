#!/usr/bin/env ruby

class LimitedInteger
  attr_accessor :value

  def initialize(n)
    raise TypeError.new("#{n} is not an Integer") unless n.is_a?(Fixnum)
    raise IOError.new("#{n} is not in the range 1 <= n <= 10") unless
        (n >= 1 && n <= 10)
    self.value = n
  end

  def to_s
    self.value.to_s
  end

  def coerce(other)
    # assume other is always a numeric value ...
    # we want an error if other is anything other than Numeric
    [self.value, other]
  end

  def +(other)
    if other.is_a?(LimitedInteger)
      self.value + other.value
    elsif other.is_a?(Fixnum)
      self.value + other
    else
      raise TypeError("#{other.class} can't be coerced into a LimitedInteger or Integer")
    end
  end

  #def -@(other)
  def -(other)
    if other.is_a?(LimitedInteger)
      self.value - other.value
    elsif other.is_a?(Fixnum)
      self.value - other
    else
      raise TypeError("#{other.class} can't be coerced into a LimitedInteger or Integer")
    end
  end

  def *(other)
    if other.is_a?(LimitedInteger)
      self.value * other.value
    elsif other.is_a?(Fixnum)
      self.value * other
    else
      raise TypeError("#{other.class} can't be coerced into a LimitedInteger or Integer")
    end
  end

  def /(other)
    if other.is_a?(LimitedInteger)
      self.value / other.value
    elsif other.is_a?(Fixnum)
      self.value / other
    else
      raise TypeError("#{other.class} can't be coerced into a LimitedInteger or Integer")
    end
  end
end
