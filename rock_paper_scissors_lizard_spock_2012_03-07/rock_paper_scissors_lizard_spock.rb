#!/usr/bin/env ruby

class Player
  attr_accessor :num_plays, :plays, :responses

  def initialize(num_plays, plays)
    @num_plays = num_plays
    @plays = plays
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
  end

  def defeat_random(play)
    responses[play.strip].sample
  end

  def defeat_without_repeating(play, last_response)
    valid_responses = responses[play.strip].select{|response| response != last_response}
    responses[play.strip].sample
  end

  def format(play, response)
    "#{response[:object]} #{response[:verb]} #{play.strip}"
  end
end


if __FILE__ == $0
  plays = ARGF.collect
  num_plays = plays.next
  player = Player.new(num_plays, plays)
  last_response = nil
  for play in player.plays do
    #response = player.defeat_random(play)
    response = player.defeat_without_repeating(play, last_response)
    puts player.format(play, response)
    last_response = response
  end
end
