#!/usr/bin/env ruby

def prompt(*args)
  print(*args)
  gets.strip
end

FACES = {
  :ace   => {:name => :ace,   :display => 'A',  :value => 1},
  :two   => {:name => :two,   :display => '2',  :value => 2},
  :three => {:name => :three, :display => '3',  :value => 3},
  :four  => {:name => :four,  :display => '4',  :value => 4},
  :five  => {:name => :five,  :display => '5',  :value => 5},
  :six   => {:name => :six,   :display => '6',  :value => 6},
  :seven => {:name => :seven, :display => '7',  :value => 7},
  :eight => {:name => :eight, :display => '8',  :value => 8},
  :nine  => {:name => :nine,  :display => '9',  :value => 9},
  :ten   => {:name => :ten,   :display => '10', :value => 10},
  :jack  => {:name => :jack,  :display => 'J',  :value => 10, :rank => 11},
  :queen => {:name => :queen, :display => 'Q',  :value => 10, :rank => 12},
  :king  => {:name => :king,  :display => 'K',  :value => 10, :rank => 13}
}

SUITS = {
  :spades   => {:name => :spades,   :display => "\u2660", :rank => 1},
  :hearts   => {:name => :hearts,   :display => "\u2661", :rank => 2},
  :diamonds => {:name => :diamonds, :display => "\u2662", :rank => 3},
  :clubs    => {:name => :clubs,    :display => "\u2663", :rank => 4}
}


class Card
  attr_accessor :_face, :_suit
  
  def initialize(face, suit)
    @_face = face
    @_suit = suit
  end

  def face
    @_face[:name]
  end

  def suit
    @_suit[:name]
  end

  def value
    @_face[:value]
  end

  def to_s
    "#{@_face[:display]}#{@_suit[:display]}"
  end

  def +(other)
    if other.is_a?(Card)
      self.value + other.value
    elsif other.is_a?(Numeric)
      self.value + other
    else
      raise TypeError("#{other.class} can't be coerced into a Card or Numeric")
    end
  end

  def coerce(other)
    # assume other is always a numeric value ...
    # we want an error if other is anything other than Numeric
    [self.value, other]
  end

  def <=>(other)
    result = @_suit[:rank] <=> other._suit[:rank]
    return result unless result == 0

    self_rank = @_face[:rank] == nil ? self.value : @_face[:rank]
    other_rank = other._face[:rank] == nil ? other.value : other._face[:rank]
    self_rank <=> other_rank
  end
end


class Deck
  attr_accessor :cards

  def initialize(faces=FACES, suits=SUITS)
    @cards = []
    faces.each do |face_type, face|
      suits.each do |suit_type, suit|
        @cards << Card.new(face, suit)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal
    @cards.shift
  end

  def size
    @cards.length
  end

  def each(&block)
    @cards.each(&block)
  end

  def sort!
    @cards.sort!
  end
end


class Shoe < Deck
  attr_accessor :cards

  def initialize(num_decks=1, faces=FACES, suits=SUITS)
    raise "A blackjack shoe must have 1, 2, 4, 6, or 8 decks" if 
          ![1,2,4,6,8].include?(num_decks)
    @cards = []
    (1..num_decks).each { |n| @cards.concat( Deck.new(faces, suits).cards ) }
  end
end


class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def to_s
    @cards.collect { |card| card.to_s }.join('  ')
  end

  def size
    @cards.length
  end

  def hit!(card)
    @cards.push(card)
  end

  def include?(face)
    @cards.select { |card| card.face == face }.length > 0
  end

  def blackjack?
    @cards.length == 2 && self.include?(:ace) &&
        (self.include?(:ten) || self.include?(:jack) ||
         self.include?(:queen) || self.include?(:king))
  end

  def value
    return 0 if @cards.length == 0
    value = @cards.collect { |card| card.value }.inject(:+)
    aces = @cards.select { |card| card.face == :ace }
    while aces.length > 0 && value < 12 do
      value += 10
      aces.pop
    end
    value
  end

  def bust?
    self.value > 21
  end
end


PLAYER = {:wins => 0, :pushes => 0}

class Blackjack
  attr_accessor :shoe, :house, :players

  def initialize
    @house = {:games => 0}
    @players = {}
  end

  def play
    puts
    puts "$$ CASINO RUBY BLACKJACK $$".center(80)
    puts "Practice against Casino Ruby before losing it all in Vegas".center(80)
    puts

    shoe_size = prompt('How many decks in the shoe? [1/2/4/6/8] ').to_i
    @shoe = Shoe.new(shoe_size)
    @shoe.shuffle!

    num_players = prompt('How many players? [between 1 and 7] ').to_i
    raise "#{num_players} is an invalid number of players" if
        num_players < 1 || num_players > 7
    (1..num_players).each { |i| @players[i] = PLAYER.clone }

    continue = true
    while continue
      continue = self.next_game
    end

    puts "\n"
    puts "+++++ The Final Tally +++++".center(80)
    puts "Out of #{@house[:games]} games played:"
    @players.each do |player_num, player|
      puts "Player #{player_num} won #{player[:wins]} " +
           "and pushed #{player[:pushes]}."
    end
  end

  def next_game
    @house[:games] += 1
    continue = true
    puts "\n"
    puts "===== GAME #{@house[:games]} =====".center(80)

    if @shoe.size <= (6 * (@players.size + 1))
      puts "FINAL ROUND!".center(80)
      continue = false
    end

    self.deal_initial_hands

    # each player plays their turn
    busts = 0
    @players.each do |player_num, player|
      self.print_status
      hand = player[:hand]
      while !(hand.blackjack? || hand.bust?) && hand.value < 21 do
        if @shoe.size == 1
          puts "Player #{player_num}: Sorry! Last card in shoe goes to HOUSE."
          break
        end
        response = prompt("Player #{player_num}: Hit or Stand? [h/s] ").downcase
        raise "'#{response}' is an invalid response" if
            !(response.start_with?('h') || response.start_with?('s'))
        break if response.start_with?('s')
        hand.hit!(@shoe.deal)
        self.print_player_status(player_num, player)
      end
      busts += 1 if hand.bust?
    end

    # the house plays, if necessary
    if busts < @players.size
      hand = @house[:hand]
      while @shoe.size > 0 &&
          !(hand.blackjack? || hand.bust?) && hand.value < 18 do
        hand.hit!(@shoe.deal)
        puts "HOUSE hits..."
      end
    end

    # show results
    puts "-- Game #{@house[:games]} Results --".center(80)
    self.print_status
    @players.each do |player_num, player|
      result = "Loss!"
      print "Player #{player_num}: "
      if @house[:hand].blackjack?
        if player[:hand].blackjack?
          player[:pushes] += 1
          result = "push"
        end
      elsif player[:hand].blackjack?
        player[:wins] += 1
        result = "Win!"
      elsif player[:hand].bust? && @house[:hand].bust?
        player[:pushes] += 1
        result = "push"
      else
        if @house[:hand].bust?
          player[:wins] += 1
          result = "Win!"
        elsif player[:hand].bust?
          result = "Loss!"
        elsif player[:hand].value == @house[:hand].value
          player[:pushes] += 1
          result = "push"
        elsif player[:hand].value > @house[:hand].value
          player[:wins] += 1
          result = "Win!"
        end
      end
      puts result
    end
    
    # another game?
    if continue
      response = prompt("\n\nPlay another round? (y/n) ")
      if !response.downcase.start_with?('y')
        continue = false
      end
    end
    continue
  end

  def deal_initial_hands
    @players.each { |player_num, player| player[:hand] = Hand.new }
    self.deal_one_card_to_each_player
    @house[:hand] = Hand.new
    @house[:hand].hit!( @shoe.deal )
    self.deal_one_card_to_each_player
  end
  
  def deal_one_card_to_each_player
    @players.each { |player_num, player| player[:hand].hit!( @shoe.deal ) }
  end

  def print_status
    puts "\nHOUSE: #{@house[:hand]}  #{self.blackjack_or_bust(@house[:hand])}"
    @players.each do |player_num, player|
      self.print_player_status(player_num, player)
    end
    puts
  end

  def print_player_status(player_num, player)
    puts "Player #{player_num}: #{player[:hand]}  " +
        "#{self.blackjack_or_bust(player[:hand])}"
  end

  def blackjack_or_bust(hand)
    return "** Blackjack! **" if hand.blackjack?
    return "** Bust! **" if hand.bust?
    return ""
  end
end


if __FILE__ == $0
  game = Blackjack.new
  game.play
end
