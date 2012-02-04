#!/usr/bin/env ruby

class Number
  attr_accessor :number, :digits, :teens, :tens, :bignums

  def initialize(n)
    if n[0] == '-'
      @negative = 'negative '
      @number = n[1,n.length]
    else
      @negative = ''
      @number = n
    end

    @digits = {'0' => '',
               '1' => 'one',
               '2' => 'two',
               '3' => 'three',
               '4' => 'four',
               '5' => 'five',
               '6' => 'six',
               '7' => 'seven',
               '8' => 'eight',
               '9' => 'nine'
              }
  
    @teens = {'10' => 'ten',
              '11' => 'eleven',
              '12' => 'twelve',
              '13' => 'thirteen',
              '14' => 'fourteen',
              '15' => 'fifteen',
              '16' => 'sixteen',
              '17' => 'seventeen',
              '18' => 'eighteen',
              '19' => 'nineteen'
             }
    
    @tens = {'20' => 'twenty',
             '30' => 'thirty',
             '40' => 'forty',
             '50' => 'fifty',
             '60' => 'sixty',
             '70' => 'seventy',
             '80' => 'eighty',
             '90' => 'ninety'
            }

  @bignums = ['', 'thousand', 'million', 'billion', 'trillion', 'quadrillion',
              'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion']
  end

  def segmentize
    #
    # Break numbers into 3-digit segments (i.e., into blocks of hundreds) for processing.
    #
    segments = []
    n = @number.reverse
    while n.slice(0,3) != "" do
      segment = n.slice!(0,3).reverse
      segments.push(segment)
    end
    segments.reverse
  end

  def parse_hundred(n)
    #
    # Convert a 3-digit number (i.e. in the hundreds) into English
    #
    english = []

    if n[-3] and n[-3] != '0'
      english.push( "#{@digits[n[-3]]} hundred" )
    end

    if n[-2] and n[-2] != '0'
      if n[-2] == '1'
        english.push( "#{@teens[n[-2,2]]}" )
      else
        ten = "#{n[-2]}0"
        english.push( "#{@tens[ten]} #{@digits[n[-1]]}".strip )
      end
    elsif n[-1] != '0'
      english.push( "#{@digits[n[-1]]}" )
    end

    english.join(' ')
  end

  #def to_english
  #  #
  #  # Process number in 3-digit segments, assembling with the appropriate
  #  # value indicator (e.g., thousand, million) in place
  #  #
  #  if @number == '0'
  #    return 'zero'
  #  end

  #  english = []
  #  segments = segmentize.reverse
  #  segments.each_index do |index|
  #    segment_number = parse_hundred(segments[index])
  #    if segment_number != ''
  #      english.push( "#{segment_number} #{@bignums[index]}".strip )
  #    end
  #  end

  #  "#{@negative}#{english.reverse.join(' ')}"
  #end

  #
  # j2's logic
  #
  #def to_english(number)
  #  english_string = ""
  #  number_string = number.to_s.reverse
  #  parsed_array = number_string.scan(/\d{3}|\d+/)
  #  parsed_array.each_with_index do |triplet, int|
  #    if triplet.to_i > 0
  #      english_string.insert(0, "#{triplet_to_english(triplet.reverse)} #{num_group_to_english(int)}")
  #      english_string.insert(0, ', ') unless int==parsed_array.length-1
  #    end
  #  end
  #  english_string.insert(0, 'negative ') if number_string.end_with?('-')
  #  return english_string.gsub(/ +/, ' ')
  #end

  def to_english()
    english_string = ""
    number_string = @number.to_s.reverse
    parsed_array = number_string.scan(/\d{3}|\d+/)
    parsed_array.each_with_index do |triplet, int|
      if triplet.to_i > 0
        english_string.insert(0, "#{parse_hundred(triplet.reverse)} #{@bignums[int]}")
        english_string.insert(0, ', ') unless int==parsed_array.length-1
      end
    end
    english_string.insert(0, "#{@negative}")
    return english_string.gsub(/ +/, ' ')
  end
end

if __FILE__ == $0
  n = Number.new ARGV[0]
  puts n.to_english
end
