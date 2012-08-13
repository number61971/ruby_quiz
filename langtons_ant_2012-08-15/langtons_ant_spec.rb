require_relative './langtons_ant'
include RSpec::Matchers

describe 'Grid' do
  before(:each) do
    @grid = Grid.new(3,3)
  end

  it 'should initialize the grid to white' do
    @grid[1,1].should == 1
    @grid[1,2].should == 1
    @grid[1,3].should == 1
    @grid[2,1].should == 1
    @grid[2,2].should == 1
    @grid[2,3].should == 1
    @grid[3,1].should == 1
    @grid[3,2].should == 1
    @grid[3,3].should == 1
  end

  it 'should toggle the color of a given grid spot' do
    coordinates = [1,1]
    @grid.toggle(*coordinates)
    @grid[*coordinates].should == -1
    @grid.toggle(*coordinates)
    @grid[*coordinates].should == 1

    coordinates = [3,2]
    @grid.toggle(*coordinates)
    @grid[*coordinates].should == -1
  end
end


describe 'Ant' do
  before(:each) do
    @ant = Ant.new(Grid.new(10,10))
    @ant.direction = 'north'
    @ant.x = 5
    @ant.y = 5
  end

  it 'should change direction correctly when callling turn_left!' do
    @ant.turn_left!
    @ant.direction.should == 'west'
    @ant.turn_left!
    @ant.direction.should == 'south'
    @ant.turn_left!
    @ant.direction.should == 'east'
    @ant.turn_left!
    @ant.direction.should == 'north'
  end

  it 'should change direction correctly when callling turn_right!' do
    @ant.turn_right!
    @ant.direction.should == 'east'
    @ant.turn_right!
    @ant.direction.should == 'south'
    @ant.turn_right!
    @ant.direction.should == 'west'
    @ant.turn_right!
    @ant.direction.should == 'north'
  end

  describe 'directional travel' do
    it 'should go up one square when go_north! is called' do
      @ant.go_north!
      @ant.position.should == [5,4]
    end

    it 'should go right one square when go_east! is called' do
      @ant.go_east!
      @ant.position.should == [6,5]
    end

    it 'should go down one square when go_south! is called' do
      @ant.go_south!
      @ant.position.should == [5,6]
    end

    it 'should go left one square when go_west! is called' do
      @ant.go_east!
      @ant.position.should == [6,5]
    end
  end

  describe 'move!' do
    describe 'the ant is on a white square' do
      it 'should flip the square to black' do
        @ant.move!
        @ant.grid[5,5].should == -1
      end

      it 'should turn right' do
        @ant.should_receive(:turn_right!)
        @ant.move!
      end

      it 'should go_east!' do
        @ant.should_receive(:go_east!)
        @ant.move!
      end
    end

    describe 'the ant is on a black square' do
      before(:each) do
        @ant.grid.toggle(@ant.x, @ant.y)
      end

      it 'should flip the square to white' do
        @ant.move!
        @ant.grid[5,5].should == 1
      end

      it 'should turn left' do
        @ant.should_receive(:turn_left!)
        @ant.move!
      end

      it 'should go_west!' do
        @ant.should_receive(:go_west!)
        @ant.move!
      end
    end
  end
end
