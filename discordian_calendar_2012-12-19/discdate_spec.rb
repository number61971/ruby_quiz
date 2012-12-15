require_relative './discdate'
include RSpec::Matchers

describe 'Date' do
  describe '#after_st_tibs_day?' do
    it "should return true if the date is on or after St Tib's Day" do
      Date.new(2012,1,5).after_st_tibs_day?.should be_false
      Date.new(2012,2,28).after_st_tibs_day?.should be_false
      Date.new(2012,2,29).after_st_tibs_day?.should be_true
      Date.new(2012,3,1).after_st_tibs_day?.should be_true
      Date.new(1971,2,28).after_st_tibs_day?.should be_false
      Date.new(1971,3,1).after_st_tibs_day?.should be_false
    end
  end

  describe '#discday' do
    it 'should return the Discordian day of the month' do
      Date.new(2012,1,5).discday.should == 5 # Mungday, Chaos 5
      Date.new(2012,2,19).discday.should == 50 # Chaoflux, Chaos 50
      Date.new(2012,2,29).discday.should == 0 # St Tib's Day
      Date.new(2012,3,19).discday.should == 5 # Mojoday, Discord 5
      Date.new(2012,3,25).discday.should == 11 # Jesus/Love Your Neighbor Day, Discord 11
      Date.new(2012,4,6).discday.should == 23 # Jake Day (option 1), Discord 23
      Date.new(2012,5,3).discday.should == 50 # Discoflux, Discord 50
      Date.new(2012,5,21).discday.should == 68 # St Camping's Day, Discord 68
      Date.new(2012,5,23).discday.should == 70 # Jake Day (option 2), Discord 70
      Date.new(2012,5,25).discday.should == 72 # Towel Day, Discord 72
      Date.new(2012,5,31).discday.should == 5 # Sayaday, Confusion 5
      Date.new(2012,7,2).discday.should == 37 # Mid Year's Day, Confusion 37
      Date.new(2012,7,5).discday.should == 40 # X-Day, Confusion 40
      Date.new(2012,7,15).discday.should == 50 # Confuflux, Confusion 50
      Date.new(2012,8,10).discday.should == 3 # Multiversal Underwear Day, Bureaucracy 3
      Date.new(2012,8,12).discday.should == 5 # Zaraday, Bureaucracy 5
      Date.new(2012,9,26).discday.should == 50 # Bureflux, Bureaucracy 50
      Date.new(2012,10,24).discday.should == 5 # Maladay, The Aftermath 5
      Date.new(2012,12,8).discday.should == 50 # Afflux, The Aftermath 50
    end
  end

  describe '#discmonth' do
    it 'should return the Discordian month' do
      Date.new(2012,1,5).discmonth.should == 1 # Mungday, Chaos 5
      Date.new(2012,2,19).discmonth.should == 1 # Chaoflux, Chaos 50
      Date.new(2012,2,29).discmonth.should == 0 # St Tib's Day
      Date.new(2012,3,19).discmonth.should == 2 # Mojoday, Discord 5
      Date.new(2012,3,25).discmonth.should == 2 # Jesus/Love Your Neighbor Day, Discord 11
      Date.new(2012,4,6).discmonth.should == 2 # Jake Day (option 1), Discord 23
      Date.new(2012,5,3).discmonth.should == 2 # Discoflux, Discord 50
      Date.new(2012,5,21).discmonth.should == 2 # St Camping's Day, Discord 68
      Date.new(2012,5,23).discmonth.should == 2 # Jake Day (option 2), Discord 70
      Date.new(2012,5,25).discmonth.should == 2 # Towel Day, Discord 72
      Date.new(2012,5,31).discmonth.should == 3 # Sayaday, Confusion 5
      Date.new(2012,7,2).discmonth.should == 3 # Mid Year's Day, Confusion 37
      Date.new(2012,7,5).discmonth.should == 3 # X-Day, Confusion 40
      Date.new(2012,7,15).discmonth.should == 3 # Confuflux, Confusion 50
      Date.new(2012,8,10).discmonth.should == 4 # Multiversal Underwear Day, Bureaucracy 3
      Date.new(2012,8,12).discmonth.should == 4 # Zaraday, Bureaucracy 5
      Date.new(2012,9,26).discmonth.should == 4 # Bureflux, Bureaucracy 50
      Date.new(2012,10,24).discmonth.should == 5 # Maladay, The Aftermath 5
      Date.new(2012,12,8).discmonth.should == 5 # Afflux, The Aftermath 50
    end
  end

  describe '#discyear' do
    it 'should return the Discordian year (YOLD)' do
      Date.new(2012,1,1).discyear.should == 3178
      Date.new(1971,2,1).discyear.should == 3137
    end
  end

  describe '#discwday' do
    it 'should return the Discordian day of the week' do
      Date.new(1971,1,1).discwday.should == 0
      Date.new(1971,1,2).discwday.should == 1
      Date.new(1971,1,3).discwday.should == 2
      Date.new(1971,1,4).discwday.should == 3
      Date.new(1971,1,5).discwday.should == 4
      Date.new(1971,1,6).discwday.should == 0
      Date.new(1971,1,7).discwday.should == 1
      Date.new(2012,1,1).discwday.should == 0
    end
  end

  describe '#sweetmorn?' do
    it 'should return true if the date is Sweetmorn' do
      Date.new(1971,1,1).sweetmorn?.should == true
      Date.new(1971,1,2).sweetmorn?.should == false
      Date.new(1971,1,3).sweetmorn?.should == false
      Date.new(1971,1,4).sweetmorn?.should == false
      Date.new(1971,1,5).sweetmorn?.should == false
      Date.new(1971,1,6).sweetmorn?.should == true
      Date.new(1971,1,7).sweetmorn?.should == false
      Date.new(2012,1,1).sweetmorn?.should == true
    end
  end

  describe '#boomtime?' do
    it 'should return true if the date is Boomtime' do
      Date.new(1971,1,1).boomtime?.should == false
      Date.new(1971,1,2).boomtime?.should == true
      Date.new(1971,1,3).boomtime?.should == false
      Date.new(1971,1,4).boomtime?.should == false
      Date.new(1971,1,5).boomtime?.should == false
      Date.new(1971,1,6).boomtime?.should == false
      Date.new(1971,1,7).boomtime?.should == true
      Date.new(2012,1,2).boomtime?.should == true
    end
  end

  describe '#pungenday?' do
    it 'should return true if the date is Pungenday' do
      Date.new(1971,1,1).pungenday?.should == false
      Date.new(1971,1,2).pungenday?.should == false
      Date.new(1971,1,3).pungenday?.should == true
      Date.new(1971,1,4).pungenday?.should == false
      Date.new(1971,1,5).pungenday?.should == false
      Date.new(1971,1,6).pungenday?.should == false
      Date.new(1971,1,8).pungenday?.should == true
      Date.new(2012,1,3).pungenday?.should == true
    end
  end

  describe '#prickle_prickle?' do
    it 'should return true if the date is Prickle-Prickle' do
      Date.new(1971,1,1).prickle_prickle?.should == false
      Date.new(1971,1,2).prickle_prickle?.should == false
      Date.new(1971,1,3).prickle_prickle?.should == false
      Date.new(1971,1,4).prickle_prickle?.should == true
      Date.new(1971,1,5).prickle_prickle?.should == false
      Date.new(1971,1,6).prickle_prickle?.should == false
      Date.new(1971,1,9).prickle_prickle?.should == true
      Date.new(2012,1,4).prickle_prickle?.should == true
    end
  end

  describe '#setting_orange' do
    it 'should return true if the date is Setting Orange' do
      Date.new(1971,1,1).setting_orange?.should == false
      Date.new(1971,1,2).setting_orange?.should == false
      Date.new(1971,1,3).setting_orange?.should == false
      Date.new(1971,1,4).setting_orange?.should == false
      Date.new(1971,1,5).setting_orange?.should == true
      Date.new(1971,1,6).setting_orange?.should == false
      Date.new(1971,1,10).setting_orange?.should == true
      Date.new(2012,1,5).setting_orange?.should == true
    end
  end

  describe '#st_tibs_day?' do
    it "should return true if the date is St Tib's Day" do
      Date.new(2012,2,28).st_tibs_day?.should be_false
      Date.new(2012,2,29).st_tibs_day?.should be_true
      Date.new(2012,3,1).st_tibs_day?.should be_false
    end
  end

  describe '#mungday?' do
    it 'should return true if the date is Mungday' do
      Date.new(2012,1,5).mungday?.should be_true
      Date.new(2012,2,29).mungday?.should be_false
      Date.new(2012,3,1).mungday?.should be_false
    end
  end

  describe '#chaoflux?' do
    it 'should return true if the date is Chaoflux' do
      Date.new(2012,1,5).chaoflux?.should be_false
      Date.new(2012,2,29).chaoflux?.should be_false
      Date.new(2012,2,19).chaoflux?.should be_true
      Date.new(2012,3,1).chaoflux?.should be_false
    end
  end

  describe '#mojoday?' do
    it 'should return true if the date is Mojoday' do
      Date.new(2012,1,5).mojoday?.should be_false
      Date.new(2012,2,29).mojoday?.should be_false
      Date.new(2012,3,1).mojoday?.should be_false
      Date.new(2012,3,19).mojoday?.should be_true
    end
  end

  describe '#discoflux?' do
    it 'should return true if the date is Discoflux' do
      Date.new(2012,1,5).discoflux?.should be_false
      Date.new(2012,2,29).discoflux?.should be_false
      Date.new(2012,3,1).discoflux?.should be_false
      Date.new(2012,5,3).discoflux?.should be_true
    end
  end

  describe '#syaday?' do
    it 'should return true if the date is Sayaday' do
      Date.new(2012,1,5).syaday?.should be_false
      Date.new(2012,2,29).syaday?.should be_false
      Date.new(2012,3,1).syaday?.should be_false
      Date.new(2012,5,31).syaday?.should be_true
    end
  end

  describe '#confuflux?' do
    it 'should return true if the date is Confuflux' do
      Date.new(2012,1,5).confuflux?.should be_false
      Date.new(2012,2,29).confuflux?.should be_false
      Date.new(2012,3,1).confuflux?.should be_false
      Date.new(2012,7,15).confuflux?.should be_true
    end
  end

  describe '#zaraday?' do
    it 'should return true if the date is Zaraday' do
      Date.new(2012,1,5).zaraday?.should be_false
      Date.new(2012,2,29).zaraday?.should be_false
      Date.new(2012,3,1).zaraday?.should be_false
      Date.new(2012,8,12).zaraday?.should be_true
    end
  end

  describe '#bureflux?' do
    it 'should return true if the date is Bureflux' do
      Date.new(2012,1,5).bureflux?.should be_false
      Date.new(2012,2,29).bureflux?.should be_false
      Date.new(2012,3,1).bureflux?.should be_false
      Date.new(2012,9,26).bureflux?.should be_true
    end
  end

  describe '#maladay?' do
    it 'should return true if the date is Maladay' do
      Date.new(2012,1,5).maladay?.should be_false
      Date.new(2012,2,29).maladay?.should be_false
      Date.new(2012,3,1).maladay?.should be_false
      Date.new(2012,10,24).maladay?.should be_true
    end
  end

  describe '#afflux?' do
    it 'should return true if the date is Afflux' do
      Date.new(2012,1,5).afflux?.should be_false
      Date.new(2012,2,29).afflux?.should be_false
      Date.new(2012,3,1).afflux?.should be_false
      Date.new(2012,12,8).afflux?.should be_true
    end
  end

  describe '#st_campings_day?' do
    it "should return true if the date is St Camping's Day" do
      Date.new(2012,1,5).st_campings_day?.should be_false
      Date.new(2012,2,29).st_campings_day?.should be_false
      Date.new(2012,3,1).st_campings_day?.should be_false
      Date.new(2012,5,21).st_campings_day?.should be_true
    end
  end

  describe '#multiversal_underwear_day?' do
    it 'should return true if the date is Multiversal Underwear Day' do
      Date.new(2012,1,5).multiversal_underwear_day?.should be_false
      Date.new(2012,2,29).multiversal_underwear_day?.should be_false
      Date.new(2012,3,1).multiversal_underwear_day?.should be_false
      Date.new(2012,8,10).multiversal_underwear_day?.should be_true
    end
  end
end
