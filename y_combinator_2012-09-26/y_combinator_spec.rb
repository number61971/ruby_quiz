require_relative './y_combinator'
include RSpec::Matchers

describe 'factorial' do
  it 'should correctly calculate the factorial of positive integers' do
    factorial(0).should == 1
    factorial(3).should == 6
    factorial(4).should == 24
    factorial(5).should == 120
  end
end

describe 'fibonacci' do
  it 'should correctly calculate the fibonacci sequence' do
    fibonacci(0).should == 0
    fibonacci(1).should == 1
    fibonacci(2).should == 1
    fibonacci(3).should == 2
    fibonacci(4).should == 3
    fibonacci(5).should == 5
    fibonacci(6).should == 8
  end
end
