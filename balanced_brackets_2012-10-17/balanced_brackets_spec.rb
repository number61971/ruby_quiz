require_relative './balanced_brackets'
include RSpec::Matchers

describe 'balance_checker' do
  it 'should correctly note when brackets are unbalanced' do
    balance_checker('[]').should be_true
    balance_checker('][][').should be_false
    balance_checker('][][][').should be_false
    balance_checker(']]][[[][').should be_false
    balance_checker('][]][][][[').should be_false
    balance_checker('][[][]]]][[[').should be_false
    balance_checker(']][][[[]]][][[').should be_false
    balance_checker('[][[][][[][]]][]').should be_true
    balance_checker('[[[[[]]][[][]]][]]').should be_true
    balance_checker('[][[][][[]]]]][]').should be_false
    balance_checker('[[[[[]][[[][]]][]]').should be_false
    balance_checker('[[]').should be_false
    balance_checker('[]]').should be_false
  end
end
