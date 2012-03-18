module RubyWarrior
  module Units
    class Archer < Base
      def initialize
        add_abilities :shoot!, :look
      end
      
      def play_turn(turn)
        [:forward, :left, :right].each do |direction|
          turn.look(direction).each do |space|
            if space.player?
              turn.shoot!(direction)
              return
            elsif !space.empty?
              break
            end
          end
        end
      end
      
      def shoot_power
        3
      end
      
      def max_health
        7
      end
      
      def character
        "a"
      end
    end
  end
end
