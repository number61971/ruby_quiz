require_relative './limited_integer'
include RSpec::Matchers

describe 'LimitedInteger' do
  describe '#initialize' do
    it 'should only accept integer values' do
      lambda {LimitedInteger.new('blah')}.should raise_error(TypeError)
      lambda {LimitedInteger.new(3.14159)}.should raise_error(TypeError)
      lambda {LimitedInteger.new(3)}.should_not raise_error(TypeError)
    end

    it 'should disallow values less than 1' do
      lambda {LimitedInteger.new(0)}.should raise_error(IOError)
      lambda {LimitedInteger.new(-2)}.should raise_error(IOError)
      lambda {LimitedInteger.new(1)}.should_not raise_error(IOError)
    end

    it 'should disallow values greater than 10' do
      lambda {LimitedInteger.new(11)}.should raise_error(IOError)
      lambda {LimitedInteger.new(10)}.should_not raise_error(IOError)
    end
  end

  describe '#to_s' do
    it 'should create an Integer-like string representation' do
      li = LimitedInteger.new(5)
      li.to_s.should == '5'
    end
  end

  describe '#inspect' do
    it 'should create an Integer-like inspect representation' do
      li = LimitedInteger.new(5)
      li.inspect.should == '5'
    end
  end

  describe '+' do
    it 'should correctly add two LimitedIntegers or Integers' do
      (LimitedInteger.new(1) + LimitedInteger.new(2)).should == 3
      (LimitedInteger.new(1) + 2).should == 3
      (1 + LimitedInteger.new(2)).should == 3
    end
  end

  describe '-' do
    it 'should correctly subtract two LimitedIntegers' do
      (LimitedInteger.new(3) - LimitedInteger.new(2)).should == 1
      (LimitedInteger.new(3) - 2).should == 1
      (3 - LimitedInteger.new(2)).should == 1
    end
  end

  describe '*' do
    it 'should correctly multiply two LimitedIntegers' do
      (LimitedInteger.new(2) * LimitedInteger.new(3)).should == 6
      (LimitedInteger.new(2) * 3).should == 6
      (2 * LimitedInteger.new(3)).should == 6
    end
  end

  describe '/' do
    it 'should correctly multiply two LimitedIntegers' do
      (LimitedInteger.new(6) / LimitedInteger.new(3)).should == 2
      (LimitedInteger.new(6) / 3).should == 2
      (6 / LimitedInteger.new(3)).should == 2
    end
  end
end
