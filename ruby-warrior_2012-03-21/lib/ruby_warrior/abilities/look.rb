module RubyWarrior
  module Abilities
    class Look < Base
      def description
        "Returns an array of up to three Spaces in the given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        verify_direction(direction)
        [1, 2, 3].map do |amount|
          space(direction, amount)
        end
      end
    end
  end
end
