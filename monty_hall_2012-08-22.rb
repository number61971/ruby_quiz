#!/usr/bin/env ruby

class Player
  attr_accessor :chosen_door

  def initialize(doors)
    @chosen_door = choose_door(doors)
  end

  def choose_door(doors)
    doors[ rand(0..doors.length-1) ]
  end

  def win?
    @chosen_door == 'car'
  end
end


class Steadfast < Player
  def make_deal(door)
    # do nothing: this player always sticks with his/her initial choice
  end
end


class Fickle < Player
  def make_deal(door)
    # this player always chooses the remaining door
    @chosen_door = door
  end
end


class Game
  attr_accessor :doors, :player

  def initialize(player_type)
    @doors = ['goat','goat','car'].shuffle
    @player = player_type.new(@doors)
  end

  def lets_make_a_deal
    @doors.delete_at( @doors.index(@player.chosen_door) )
    @doors.delete_at( @doors.index('goat') )
    @player.make_deal(@doors[0])
    @player.win?
  end
end


if __FILE__ == $0
  simulations = ARGV[0].to_i ||= 1000
  [Steadfast, Fickle].each do |player|
    wins = 0
    (1..simulations).each do |sim|
      game = Game.new(player)
      result = game.lets_make_a_deal
      wins += 1 if result
    end
    pct = "%4.2f" % ((Float(wins) / Float(simulations)) * 100)
    print "The #{player} player won #{wins} out of #{simulations} times "
    puts "(#{pct}%)."
  end
end
