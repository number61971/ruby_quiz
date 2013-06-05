class FizzBuzz
  def self.evaluate(number)
    return 'fizzbuzz' if self.fizzbuzz?(number)
    return 'fizz'     if self.fizz?(number)
    return 'buzz'     if self.buzz?(number)
    return number.to_s
  end

  def self.fizz?(number)
    number % 3 == 0
  end

  def self.buzz?(number)
    number % 5 == 0
  end

  def self.fizzbuzz?(number)
    self.fizz?(number) && self.buzz?(number)
  end
end


describe FizzBuzz do
  it 'can evaluate a number' do
    FizzBuzz.evaluate(1).should be_true
  end

  describe '#evaluate' do
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

  ### NEW TESTS ###

  describe '#fizz?' do
    context 'returns true if a number is divisible by 3.' do
      it '3 is divisible by 3' do
        expect(FizzBuzz.fizz?(3)).to be_true
      end

      it '15 is divisible by 3' do
        expect(FizzBuzz.fizz?(15)).to be_true
      end

      it '21 is divisible by 3' do
        expect(FizzBuzz.fizz?(21)).to be_true
      end
    end

    context 'returns false if a number is not divisible by 3.' do
      it '2 is not divisible by 3' do
        expect(FizzBuzz.fizz?(2)).to be_false
      end

      it '10 is not divisible by 3' do
        expect(FizzBuzz.fizz?(10)).to be_false
      end

      it '16 is not divisible by 3' do
        expect(FizzBuzz.fizz?(16)).to be_false
      end
    end
  end

  describe '#buzz?' do
    context 'returns true if a number is divisible by 5.' do
      it '5 is divisible by 5' do
        expect(FizzBuzz.buzz?(5)).to be_true
      end

      it '15 is divisible by 5' do
        expect(FizzBuzz.buzz?(15)).to be_true
      end

      it '30 is divisible by 5' do
        expect(FizzBuzz.buzz?(30)).to be_true
      end
    end

    context 'returns false if a number is not divisible by 5.' do
      it '3 is not divisible by 5' do
        expect(FizzBuzz.buzz?(3)).to be_false
      end

      it '9 is not divisible by 5' do
        expect(FizzBuzz.buzz?(9)).to be_false
      end

      it '21 is not divisible by 5' do
        expect(FizzBuzz.buzz?(21)).to be_false
      end
    end
  end

  describe '#fizzbuzz?' do
    context 'returns true if a number is divisible both by 3 and by 5.' do
      it '15 is divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(15)).to be_true
      end

      it '30 is divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(30)).to be_true
      end
    end

    context 'returns false if a number is not divisible both by 3 and by 5.' do
      it '3 is not divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(3)).to be_false
      end

      it '5 is not divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(5)).to be_false
      end

      it '10 is not divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(10)).to be_false
      end

      it '21 is not divisible by 3 and by 5' do
        expect(FizzBuzz.fizzbuzz?(21)).to be_false
      end
    end
  end
end
