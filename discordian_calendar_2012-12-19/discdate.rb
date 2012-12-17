#!/usr/bin/env ruby

require 'date'

class Date
  DISCDAYNAMES = [
    'Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle-Prickle', 'Setting Orange'
  ]

  DISCMONTHNAMES = [
    nil, 'Chaos', 'Discord', 'Confusion', 'Bureaucracy', 'The Aftermath'
  ]

  #
  # NB: 0 is used to indicate St Tib's Day for both day and month, since it is
  # not actually a part of any Discordian month.
  #
  
  def after_st_tibs_day?
    leap? && yday > 59
  end

  def discday
    # be sure to account for St Tib's Day
    if st_tibs_day?
      dday = 0
    else
      dday = after_st_tibs_day? ? (yday - 1) % 73 : yday % 73
    end
    dday
  end

  def discmonth
    # be sure to account for St Tib's Day
    if st_tibs_day?
      dmonth = 0
    else
      dmonth = after_st_tibs_day? ? ((yday - 1) / 73) + 1 : (yday / 73) + 1
    end
    dmonth
  end

  def discyear
    year + 1166
  end

  def discwday
    (yday - 1) % 5
  end

  #
  # Discordian weekdays
  #
  def sweetmorn?
    discwday == 0
  end

  def boomtime?
    discwday == 1
  end

  def pungenday?
    discwday == 2
  end

  def prickle_prickle?
    discwday == 3
  end

  def setting_orange?
    discwday == 4
  end

  #
  # Discordian Holydays
  #
  def st_tibs_day?
    leap? && yday == 60
  end

  def mungday?
    discmonth == 1 && discday == 5
  end

  def chaoflux?
    discmonth == 1 && discday == 50
  end

  def mojoday?
    discmonth == 2 && discday == 5
  end

  def discoflux?
    discmonth == 2 && discday == 50
  end

  def syaday?
    discmonth == 3 && discday == 5
  end

  def confuflux?
    discmonth == 3 && discday == 50
  end

  def zaraday?
    discmonth == 4 && discday == 5
  end

  def bureflux?
    discmonth == 4 && discday == 50
  end

  def maladay?
    discmonth == 5 && discday == 5
  end

  def afflux?
    discmonth == 5 && discday == 50
  end

  def st_campings_day?
    discmonth == 2 && discday == 68
  end

  def multiversal_underwear_day?
    discmonth == 4 && discday == 3
  end
end

if __FILE__ == $0
  d = Date.today
  if d.st_tibs_day?
    puts "Happy St Tib's Day, #{d.discyear} (YOLD)!"
  else
    puts "Today is #{Date::DISCDAYNAMES[d.discwday]}, day #{d.discday} " +
         "of #{Date::DISCMONTHNAMES[d.discmonth]}, " +
         "in the Year of Our Lady of Discord #{d.discyear}."
    if d.mungday?
      puts "Happy Mungday!"
    elsif d.chaoflux?
      puts "Happy Chaoflux!"
    elsif d.mojoday?
      puts "Happy Mojoday!"
    elsif d.discoflux?
      puts "Happy Discoflux!"
    elsif d.syaday?
      puts "Happy Syaday!"
    elsif d.confuflux?
      puts "Happy Confuflux!"
    elsif d.zaraday?
      puts "Happy Zaraday!"
    elsif d.bureflux?
      puts "Happy Bureflux!"
    elsif d.maladay?
      puts "Happy Maladay!"
    elsif d.afflux?
      puts "Happy Afflux!"
    elsif d.st_campings_day?
      puts "Happy St Camping's Day!"
    elsif d.multiversal_underwear_day?
      puts "Happy Multiversal Underwear Day!"
    end
  end
end
