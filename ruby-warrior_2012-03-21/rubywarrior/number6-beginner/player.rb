class RubyWarrior::Turn
  # The "warrior" passed into Player.play_turn is an instance of RubyWarrior::Turn
  # Enhancements placed here!

  def hurt?(hp=20)
    self.health < hp ? true : false
  end

  def taking_damage?(prev_health)
    self.health < prev_health ? true : false
  end

  def run_away!(direction=:forward)
    opposite_directions = {
      :forward => :backward,
      :backward => :forward,
    }
    self.walk!(opposite_directions[direction])
  end

  def see_closest_thing(direction=:forward)
    whats_seen = self.look(direction)
    for space in whats_seen
      if !space.empty?
        return space
      end
    end
    space
  end

  def identify(space)
    space.inspect.to_s
  end

  def threatened?
    whats_forward = self.see_closest_thing
    whats_backward = self.see_closest_thing(:backward)
    whats_forward.enemy? || whats_backward.enemy?
  end

  def shoot_deadliest_enemy!
    # prioritize shooting Wizards over Archers, and Wizards/Archers over anything else
    if self.threatened?
      whats_forward = self.see_closest_thing
      whats_backward = self.see_closest_thing(:backward)

      if whats_forward.enemy? && whats_backward.enemy?
        forward_id = self.identify(whats_forward)
        backward_id = self.identify(whats_backward)
        puts "forward: #{forward_id}; backward: #{backward_id}"
        if (forward_id == backward_id || forward_id == 'Wizard') || 
            (forward_id == 'Archer' && backward_id != 'Wizard')
          # either it doesn't really matter, or the forward enemy is deadliest
          self.shoot!
        else
          self.shoot!(:backward)
        end
      elsif whats_forward.enemy?
        self.shoot!
      else
        self.shoot!(:backward)
      end
    end
  end

  def fight_or_flight!
    if self.feel.enemy?
      self.attack!
    elsif self.feel(:backward).enemy?
      self.pivot!
    else
      # * Shoot Wizards on sight (they die to a sigle shot, and can't be allowed to deal their massive damage)
      # * Continue shooting provided one is healthy enough
      # * Run away if health is getting too low
      critical = 13
      whats_forward = self.see_closest_thing
      whats_backward = self.see_closest_thing(:backward)
      if whats_forward.enemy? && whats_backward.enemy?
        self.shoot_deadliest_enemy!
      elsif whats_forward.enemy?
        if self.identify(whats_forward) == 'Wizard'
          self.shoot!
        elsif self.health == critical &&
            self.feel(:backward).empty? &&
            self.look(:backward)[1].empty?
          self.run_away!
        else
          self.shoot!
        end
      else
        if self.identify(whats_backward) == 'Wizard'
          self.shoot!(:backward)
        elsif self.health == critical &&
            self.feel.empty? &&
            self.look[1].empty?
          self.walk!
        else
          self.shoot!(:backward)
        end
      end
    end
  end
end


class Player
  attr_accessor :max_health, :health, :checked_both_ways

  def play_turn(warrior)
    whats_seen_forward = warrior.see_closest_thing
    whats_seen_backward = warrior.see_closest_thing(:backward)
    whats_felt_forward = warrior.feel
    whats_felt_backward = warrior.feel(:backward)

    # Initialize tracking stats, if required
    if @max_health == nil
      @max_health, @health = [warrior.health, warrior.health]
      # initialize willingness to search everywhere
      if whats_felt_forward.wall? || whats_felt_backward.wall?
        @checked_both_ways = true
      else
        @checked_both_ways = false
      end
    end

    # Play on!
    if warrior.hurt?(@max_health)
      if warrior.threatened?
        if warrior.taking_damage?(@health)
          warrior.fight_or_flight!
        else
          warrior.shoot_deadliest_enemy!
        end
      else
        warrior.rest!
      end
    else
      # check immediate vicinity before deciding what to do
      if whats_felt_forward.wall?
        @checked_both_ways = true
        warrior.pivot!
      elsif whats_felt_forward.enemy?
        warrior.attack!
      elsif whats_felt_forward.captive?
        warrior.rescue!
      elsif whats_felt_forward.stairs?
        if @checked_both_ways
          warrior.walk!
        else
          warrior.pivot!
        end
      # immediate vicinity clear...
      elsif warrior.threatened?
        warrior.shoot_deadliest_enemy!
      elsif whats_seen_backward.captive?
        # prioritize rescue of captives
        warrior.pivot!
      else
        # go ahead and explore; it's the only way to find stairs!
        # sadly, stairs can only be felt, not seen :(
        warrior.walk!
      end
    end

    # save health after acting this turn for comparison on next turn (i.e., taking_damage?)
    @health = warrior.health
  end
end
