#!/usr/bin/env ruby

class CreditCard
  attr_accessor :number
  
  def initialize(n)
    @number = n.to_s.gsub(/\s+/, '')
  end

  def to_s
    "#{self.type} #{@number.scan(/(\d{1,4})/).join(' ')} (#{self.valid? ? "valid" : "invalid"})"
  end

  def type
    if @number[0..3] == '6011'
      return 'DISCOVER'
    elsif [34,37].include?(@number[0..1].to_i)
      return 'AMEX'
    elsif (51..55).to_a.include?(@number[0..1].to_i)
      return 'MASTERCARD'
    elsif @number[0] == '4'
      return 'VISA'
    else
      return 'unknown'
    end
  end

  def valid?
    len = @number.length
    t = self.type
    if (['DISCOVER','MASTERCARD','VISA'].include?(t) && len == 16) ||
       (t == 'AMEX' && len == 15) ||
       (t == 'VISA' && len == 13)
      return self.luhn_algorithm % 10 == 0
    else
      return false
    end
  end

  def luhn_algorithm
    digits = [] 
    @number.reverse.each_char.each_with_index { |n,i|
      if i%2 == 1
        digits.push(n.to_i * 2)
      else
        digits.push( n.to_s.to_i )
      end
    }
    return digits.flatten.inject(:+)
  end
end


if __FILE__ == $0
  ARGF.each do |line|
    puts CreditCard.new(line)
  end
end
