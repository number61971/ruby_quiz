class FizzBuzz
  def self.evaluate(number)
    if number % 5 == 0 && number % 3 == 0
      return "fizzbuzz"
    elsif number % 3 == 0
      return "fizz"
    elsif number % 5 == 0
      return "buzz"
    else
      return number.to_s
    end
  end
end
 
describe FizzBuzz do
  it 'can evaluate a number' do
    FizzBuzz.evaluate(1).should be_true
  end
  describe "#evaluate" do
    it 'can return fizz for 3' do
      FizzBuzz.evaluate(3).should eql "fizz"
    end

    it 'can return buzz for 5' do
      FizzBuzz.evaluate(5).should eql "buzz"
    end

    it 'can return the number for 7' do
      FizzBuzz.evaluate(7).should eql "7"
    end

    it 'can return fizz for 9' do
      FizzBuzz.evaluate(9).should eql "fizz"
    end

    it 'can return buzz for 10' do
      FizzBuzz.evaluate(10).should eql "buzz"
    end

    it 'can retrn fizzbuzz for 15' do
      FizzBuzz.evaluate(15).should eql "fizzbuzz"
    end

    it 'can return fizzbuzz for 30' do
      FizzBuzz.evaluate(30).should eql "fizzbuzz"
    end

  end
end
