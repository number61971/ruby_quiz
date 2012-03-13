#!/usr/bin/env ruby

class Player
  attr_accessor :num_plays, :plays, :responses, :method, :last_response

  def initialize(num_plays, plays, method="randomly")
    @num_plays = num_plays
    @plays = plays
    @method = method
    @responses = {
      'rock'     => [{:object => 'paper',    :verb => 'covers'},
                     {:object => 'Spock',    :verb => 'vaporizes'}],
      'paper'    => [{:object => 'scissors', :verb => 'cut'},
                     {:object => 'lizard',   :verb => 'eats'}],
      'scissors' => [{:object => 'rock',     :verb => 'crushes'},
                     {:object => 'Spock',    :verb => 'smashes'}],
      'lizard'   => [{:object => 'rock',     :verb => 'crushes'},
                     {:object => 'scissors', :verb => 'decapitates'}],
      'Spock'    => [{:object => 'paper',    :verb => 'disproves'},
                     {:object => 'lizard',   :verb => 'poisons'}],
    }
    @last_response = nil
  end

  def defeat(play)
    self.send("defeat_#{method}", play)
  end

  def defeat_randomly(play)
    responses[play.strip].sample
  end

  def defeat_without_repeating(play)
    valid_responses = responses[play.strip].select{|response| response[:object] != @last_response}
    response = valid_responses.sample
    @last_response = response[:object]
    response
  end

  def format(play, response)
    "#{response[:object]} #{response[:verb]} #{play.strip}"
  end
end


if __FILE__ == $0
  require 'optparse'
  options = {:method => 'randomly'} # default
  optparse = OptionParser.new do |opts|
    opts.banner = %Q(Usage: ruby rock_paper_lizard_scissors_spock.rb [-r | --random | -n | --no-repeat ]
    Script accepts input lines from stdin.
    The first line should be the number of input plays that follow.
    All other lines should be one of 'rock', 'paper', 'scissors', 'lizard', or 'Spock')
    opts.on('-h', '--help', 'Display this screen') do
      puts opts
      exit
    end
    opts.on('-r', '--random', 'Randomly defeat each play (default behavior)') do
      options[:method] = 'randomly'
    end
    opts.on('-n', '--no-repeat', 'Defeat each play without repeating the previous choice') do
      options[:method] = 'without_repeating'
    end
  end
  optparse.parse!

  plays = ARGF.collect
  num_plays = plays.next
  player = Player.new(num_plays, plays, options[:method])
  for play in player.plays do
    response = player.defeat(play)
    puts player.format(play, response)
  end
end
