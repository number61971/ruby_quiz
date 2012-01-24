#!/usr/bin/env ruby

class Person
  attr_accessor :fname, :lname, :email

  def initialize(data)
    pieces = data.split(' ')
    @fname = pieces[0]
    @lname = pieces[1]
    @email = pieces[2][/<([^>]+)>/, 1]
  end

  def send_secret_santa_email(recipient)
    puts "Dear #{recipient.fname}, I am your Secret Santa! Expect great things! Yours, #{self.fname}"
  end

  def to_s
    "#{@fname} #{@lname} <#{@email}>" 
  end
end


def group_santa_families(people)
  #
  # Must group the potential santas by family groups, from largest group of
  # family members to the smallest. This (nearly) guarantees that the simple
  # match logic of match_with_santa never results in an empty group of
  # valid_people with which to match the last santas passing through the loop.
  # (Good enough for the quiz -- and real life -- IMHO!)
  #
  families_h = {}
  people.each do |p|
    family = families_h.fetch(p.lname, [])
    family.push(p)
    families_h[p.lname] = family
  end

  families_a = []
  families_h.keys.each do |lname|
    families_a.push( families_h[lname] )
  end
  families_a.sort!{ |a,b| b.length <=> a.length }
  
  santas = []
  families_a.each do |f|
    f.each do |p|
      santas.push(p)
    end
  end
  santas
end

def match_with_santa(santa, people)
  valid_people = people.select{ |p| p.lname != santa.lname }
  match = valid_people.sample
  remaining = people.select{ |p| p != match }
  [ match, remaining ]
end

def match_santas(people)
  available = Array.new people
  matched = []
  people.each do |santa|
    match, available = match_with_santa(santa, available)
    matched.push Hash[ :santa => santa, :match => match ] 
  end
  matched
end


if __FILE__ == $0
  people = ARGF.collect{ |line| Person.new line }
  people = group_santa_families(people)
  matched = match_santas(people)
  matched.each do |m|
    m[:santa].send_secret_santa_email( m[:match] )
  end
end
