require_relative './karate_chop_kata'
include RSpec::Matchers

describe "chop" do
  it "should return the index of the array element when present, -1 if not present" do
    chop(3, []).should == -1
    chop(3, [1]).should == -1
    chop(1, [1]).should == 0
    
    chop(1, [1, 3, 5]).should == 0
    chop(3, [1, 3, 5]).should == 1
    chop(5, [1, 3, 5]).should == 2
    chop(0, [1, 3, 5]).should == -1
    chop(2, [1, 3, 5]).should == -1
    chop(4, [1, 3, 5]).should == -1
    chop(6, [1, 3, 5]).should == -1
    
    chop(1, [1, 3, 5, 7]).should == 0
    chop(3, [1, 3, 5, 7]).should == 1
    chop(5, [1, 3, 5, 7]).should == 2
    chop(7, [1, 3, 5, 7]).should == 3
    chop(0, [1, 3, 5, 7]).should == -1
    chop(2, [1, 3, 5, 7]).should == -1
    chop(4, [1, 3, 5, 7]).should == -1
    chop(6, [1, 3, 5, 7]).should == -1
    chop(8, [1, 3, 5, 7]).should == -1
  end
end
