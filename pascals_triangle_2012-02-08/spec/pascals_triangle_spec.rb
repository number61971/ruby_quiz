require_relative '../pascals_triangle'
include RSpec::Matchers

describe Integer do
  it "should correctly calculate the factorial of an integer" do
    lambda {-1.factorial}.should raise_error(NegativeFactorialError)
    0.factorial.should == 1
    1.factorial.should == 1
    2.factorial.should == 2
    3.factorial.should == 6
    4.factorial.should == 24
    5.factorial.should == 120
    6.factorial.should == 720
  end
end

describe PascalTriangle do
  let(:triangle) { PascalTriangle.new }

  context "input validation" do
    it "should reject invalid cell input data" do
      row = "NaN"
      position = 1
      lambda {triangle.validate(row, position)}.should raise_error(ArgumentError, "'NaN' is not an integer.")

      row = 1
      position = "NaN"
      lambda {triangle.validate(row, position)}.should raise_error(ArgumentError, "'NaN' is not an integer.")

      row = 1
      position = 2
      lambda {triangle.validate(row, position)}.should raise_error(InvalidPascalTriangleError)

      row = 0
      position = 1
      lambda {triangle.validate(row, position)}.should raise_error(InvalidPascalTriangleError)

      row = 1
      position = 0
      lambda {triangle.validate(row, position)}.should raise_error(InvalidPascalTriangleError)
    end

    it "should convert string input to integers" do
      row = "1"
      position = "1"
      row_out, position_out = triangle.validate(row, position)
      row_out.should be_a(Integer)
      position_out.should be_a(Integer)
    end

    it "should zero-index row and position input" do
      row = 1
      position = 1
      row_out, position_out = triangle.validate(row, position)
      row_out.should == 0
      position_out.should == 0

      row = 5
      position = 3
      row_out, position_out = triangle.validate(row, position)
      row_out.should == 4
      position_out.should == 2
    end
  end

  it "should calculate the value for any cell in the triangle" do
    row = 1
    position = 1
    triangle.calculate(row, position).should == 1

    row = 2
    position = 1
    triangle.calculate(row, position).should == 1

    row = 2
    position = 2
    triangle.calculate(row, position).should == 1

    row = 3
    position = 1
    triangle.calculate(row, position).should == 1

    row = 3
    position = 2
    triangle.calculate(row, position).should == 2

    row = 3
    position = 3
    triangle.calculate(row, position).should == 1

    row = 4
    position = 1
    triangle.calculate(row, position).should == 1

    row = 4
    position = 2
    triangle.calculate(row, position).should == 3

    row = 4
    position = 3
    triangle.calculate(row, position).should == 3

    row = 4
    position = 4
    triangle.calculate(row, position).should == 1

    row = 5
    position = 1
    triangle.calculate(row, position).should == 1

    row = 5
    position = 2
    triangle.calculate(row, position).should == 4

    row = 5
    position = 3
    triangle.calculate(row, position).should == 6

    row = 5
    position = 4
    triangle.calculate(row, position).should == 4

    row = 5
    position = 5
    triangle.calculate(row, position).should == 1
  end
end
