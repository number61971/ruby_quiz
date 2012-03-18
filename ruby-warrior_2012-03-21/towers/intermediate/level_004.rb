#  ----
# |C s |
# | @ S|
# |C s>|
#  ----

description "Your ears become more in tune with the surroundings. Listen to find enemies and captives!"
tip "Use warrior.listen to find spaces with other units, and warrior.direction_of to determine what direction they're in."
clue "Walk towards an enemy or captive with warrior.walk!(warrior.direction_of(warrior.listen.first)), once warrior.listen.empty? then head for the stairs."

time_bonus 55
ace_score 144
size 4, 3
stairs 3, 2

warrior 1, 1, :east do |u|
  u.add_abilities :listen, :direction_of
end

unit :captive, 0, 0, :east
unit :captive, 0, 2, :east
unit :sludge, 2, 0, :south
unit :thick_sludge, 3, 1, :west
unit :sludge, 2, 2, :north
