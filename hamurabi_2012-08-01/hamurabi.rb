#!/usr/bin/env ruby

def prompt(*args)                                                                
  print(*args)                                                                   
  gets.strip                                                                     
end

class Sumer
  attr_accessor :year, :died, :increase, :population, :yield, :storage
  attr_accessor :eaten, :acres, :harvested, :planted, :bushels_fed
  attr_accessor :plague_chance, :rate, :pct_died, :total_died, :pct_died_avg
  attr_accessor :term_limit

  def initialize
    @term_limit = 10
    @year = 0
    @died = 0
    @increase = 5
    @population = 95
    @pct_died = 0
    @storage = 2800
    @harvested = 3000
    @yield = 3
    @eaten = @harvested - @storage
    @acres = @harvested / @yield
    @plague_chance = nil
    @total_died = 0
    @pct_died_avg = 0
  end

  def govern!
    puts 'HAMURABI'.center(80)
    puts 'Creative Computing   Morristown, NJ'.center(80)
    puts 'Ruby port by Damon Butler'.center(80)
    puts "\n\nTry your hand at governing ANCIENT SUMERIA\n" +
         "for a ten-year term of office.\n"

    until @year >= @term_limit do
      impeached = self.play_turn
      break if impeached
    end

    if !impeached
      puts "\n\nIn your 10-year term of office, #{@pct_died_avg} of the " +
           "population starved per year on the average. A total of " +
           "#{@total_died} people died!!"
      land_per_person = @acres / @population
      puts "\nYou started with 10 acres per person and ended with " +
           "#{land_per_person} acres per person."
      if @pct_died_avg > 33 || land_per_person < 7
        self.impeached
      elsif @pct_died_avg > 10 || land_per_person < 9
        puts %Q(
Your heavy-handed performance smacks of NERO and IVAN IV.
The people (remaining) find you an unpleasnat ruler, and,
frankly, hate your guts!!)
      elsif @pct_died_avg > 3 || land_per_person < 10
        assassins = (Float(@population) * 0.8 * rand(0.0..1.0)).to_i
        puts "\nYour performance could have been somewhat better, " +
             "but really wasn't too bad at all."
        puts "#{assassins} people would dearly like to see you assassinated " +
             "...\nbut we all have our trivial problems."
      else
        puts %Q(
A fantastic performance!!! CHARLEMAGNE, DISRAELI, and JEFFERSON combined
could not have done better!)
      end
    end
    puts "\nSo long for now.\n"
  end

  def play_turn
    self.advance_year
    self.increase_population
    self.report
    self.buy_land
    self.feed_population
    self.plant_seed
    self.harvest
    self.rats
    self.births_and_immigration
    self.discontent
  end

  def advance_year
    @year += 1
  end

  def increase_population
    @population += @increase
  end

  def plague?
    if @plague_chance == nil
      @plague_chance = 100
    else
      @plague_chance = rand(1..100)
    end
    if @plague_chance <= 15 # horros, a 15% chance of plague
      @population = @population/2
      return true
    end
    false
  end

  def report
    puts "\n\nHAMURABI: I beg to report to you, in year #{year},"
    puts "#{@died} people starved, #{@increase} came to the city."
    puts "\nA HORRIBLE PLAGUE STRUCK! Half the people died." if self.plague?
    puts "\nPopulation is now #{@population}."
    puts "The city now owns #{self.acres} acres."
    if @harvested > 0
      puts "You harvested #{@yield} bushels per acre."
    else
      puts "You harvested nothing!"
    end
    puts "Rats ate #{self.eaten} bushels." 
    puts "You now have #{@storage} bushels in store."
  end

  def buy_land
    @rate = rand(18..27)
    puts "\nLand is trading at #{@rate} bushels per acre."
    loop do
      bought = prompt('How many acres do you wish to buy? ').to_i
      if bought >= 0
        if @rate * bought <= @storage
          if bought > 0
            @acres += bought
            @storage -= (@rate * bought)
          else
            self.sell_land
          end
          break
        else
          self.report_storage_amount
        end
      else
        self.demur
      end
    end
  end

  def sell_land
    loop do
      sold = prompt('How many acres do you wish to sell? ').to_i
      if sold >= 0
        if sold < @acres
          @acres -= sold 
          @storage += (@rate * sold)
          break
        else
          self.report_acreage
        end
      else
        self.demur
      end
    end
  end

  def feed_population
    loop do
      @bushels_fed = prompt(
                    "\nHow many bushels do you wish to feed your people? ").to_i
      if @bushels_fed >= 0
        if @bushels_fed <= @storage
          @storage -= @bushels_fed
          break
        else
          self.report_storage_amount
        end
      else
        self.demur
      end
    end
  end

  def plant_seed
    loop do
      @planted = prompt("\nHow many acres do you wish to plant with seed? ").to_i
      break if planted == 0
      if @planted > 0
        if @planted <= @acres
          if (Float(@planted) / 2.0) <= Float(@storage)
            if @planted < (10 * @population)
              @storage -= (@planted / 2)
              break
            else
              puts "\nBut you have only #{@population} people to tend the " +
                    'fields! Now then...'
            end
          else
            self.report_storage_amount
          end
        else
          self.report_acreage
        end
      else
        self.demur
      end
    end
  end

  def harvest
    if @planted > 0
      @yield = self.random_factor
      @harvested = @planted * @yield
    else
      @harvested = 0
    end
  end

  def rats
    if @storage > 0
      factor = self.random_factor
      if @eaten == 0 || Float(factor/2) == (Float(factor)/2.0)
        @eaten = @storage / factor
      end
      @storage = @storage - @eaten + @harvested
      @storage = 0 if @storage < 0
    else
      @eaten = 0
    end
  end

  def births_and_immigration
    factor = self.random_factor
    @increase = ((factor * ((20 * @acres) + @storage)) / @population / 100) + 1
  end

  def discontent
    content = @bushels_fed / 20 # how many people had full tummies?
    if @population < content
      @died = 0
    else
      @died = @population - content
      if Float(@died) > (0.45 * Float(@population))
        puts "\nYOU STARVED #{@died} PEOPLE IN ONE YEAR!!!"
        self.impeached
        return true
      else
        # Calculate overall performance factors
        @population = content
        @pct_died_avg = (((@year - 1) * @pct_died_avg) +
                         (@died * 100 / @population)) / @year 
        @total_died += @died
      end
    end
    false
  end

  def report_storage_amount
    puts "\nHAMURABI: Think again. You have only #{@storage} bushels of grain."+
         ' Now then...'
  end

  def report_acreage
    puts "\nHAMURABI: Think again. You own only #{acres} acres. Now then..."
  end

  def demur
    puts "\nHAMURABI: I cannot do what you wish."
  end

  def impeached
    puts %Q(
Due to this extreme mismanagement, you have not only been impeached and thrown
out of office, but you have also been declared NATIONAL FINK!!!!)
  end

  def random_factor
    rand(2..6)
  end
end

if __FILE__ == $0
  sumer = Sumer.new
  sumer.govern!
end
