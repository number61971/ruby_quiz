#!/usr/bin/env ruby

require 'date'

def prompt(*args)
  print(*args)
  gets.strip
end

class DateProcessor
  attr_accessor :start_date, :end_date, :fridays_the_13th

  def initialize
    @fridays_the_13th = []
  end

  def get_date_input(type)
    parsed_date = nil
    while parsed_date == nil
      begin
        input = prompt("Enter #{type} date: ")
        parsed_date = Date.parse(input)
      rescue ArgumentError
        begin
          parsed_date = Date.strptime(input, "%m/%d/%Y")
        rescue ArgumentError
          begin
            parsed_date = Date.strptime(input, "%m-%d-%Y")
          rescue ArgumentError
            puts "ERROR: Invalid date. Do it again until you get it right!"
          end
        end
      end
    end
    parsed_date
  end

  def get_dates
    @start_date = self.get_date_input('start')
    @end_date = self.get_date_input('end')
    if @end_date <= @start_date
      raise "Nice one, Clever Dick. But I'm not gonna bother if you can't " +
            "order your dates properly."
    end
  end

  def find_fridays_the_13th
    thirteenth = self.find_first_13th
    while thirteenth <= @end_date do
      @fridays_the_13th.push(thirteenth) if thirteenth.friday?
      thirteenth = thirteenth.next_month
    end
  end

  def find_first_13th
    this_date = @start_date
    until this_date.day == 13 do
      this_date = this_date.next_day
    end
    return this_date
  end

  def compile_useless_statistics
    self.total
    self.least_most_per_year
    self.least_most_by_month
    self.distance_between_fridays_the_13th
  end

  def total
    puts "\n#{@fridays_the_13th.length} total Fridays the 13th."
  end

  def least_most_per_year
    puts
    year_count = Hash.new { |hash,key| hash[key] = 0 }
    @fridays_the_13th.each { |d| year_count[d.year] += 1 }
    year_count = year_count.to_a.sort { |a,b| a[1] <=> b[1] }

    years = year_count.select { |y| y[1] == year_count[0][1] }
    years = years.collect { |y| y[0].to_s }.sort.join(', ')
    puts "The least number of Fridays the 13th per year: #{year_count[0][1]} " +
         "(#{years})"

    years = year_count.select { |y| y[1] == year_count[-1][1] }
    years = years.collect { |y| y[0].to_s }.sort.join(', ')
    puts "The most number of Fridays the 13th per year: #{year_count[-1][1]} " +
         "(#{years})"
  end

  def least_most_by_month
    puts
    month_count = Hash.new { |hash,key| hash[key] = 0 }
    @fridays_the_13th.each { |d| month_count[d.month] += 1 }
    month_count = month_count.to_a.sort { |a,b| a[1] <=> b[1] }

    months = month_count.select { |m| m[1] == month_count[0][1] }
    months = months.sort.collect { |m| Date::MONTHNAMES[ m[0] ] }.join(', ')
    puts "The month(s) with the least number of Fridays the 13: #{months} " +
         "(#{month_count[0][1]})"

    months = month_count.select { |m| m[1] == month_count[-1][1] }
    months = months.sort.collect { |m| Date::MONTHNAMES[ m[0] ] }.join(', ')
    puts "The month(s) with the greatest number of Fridays the 13: #{months} " +
         "(#{month_count[-1][1]})"
  end

  def distance_between_fridays_the_13th
    puts
    day_count = []
    @fridays_the_13th.each_with_index do |d,i|
      if i > 0
        day_count << (d - @fridays_the_13th[i-1]).to_i
      end
    end
    day_count.sort!
    puts "The shortest time between successive Fridays the 13th: " +
         "#{day_count[0]} days"
    puts "The greatest time between successive Fridays the 13th: " +
         "#{day_count[-1]} days"
  end
end

if __FILE__ == $0
  d = DateProcessor.new
  d.get_dates
  d.find_fridays_the_13th
  d.compile_useless_statistics
end
