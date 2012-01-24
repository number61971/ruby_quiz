#!/usr/bin/env ruby

class Person
  attr_accessor :fname, :lname, :email

  def initialize(data)
    pieces = data.split(' ')
    @fname = pieces[0]
    @lname = pieces[1]
    @email = pieces[2][/<([^>]+)>/, 1]
  end

  def to_s
    "#{@fname} #{@lname} <#{@email}>" 
  end
end


def match_with_santa(santa, people)
  valid_people = people.select{ |p| p.lname != santa.lname }
  valid_people.sample
end


if __FILE__ == $0
  people = ARGF.collect{ |line| Person.new line }
  matched_people = []
end
