#!/usr/bin/env ruby

#
# Exercise from http://www.codesandciphers.org.uk/enigma/example1.htm
# NOTE: Per exercise, ring setting, plugboard, and rotation of rotors
# are not emulated.
#

# NOTE: Per exercise, all rotors are assumed to be in the "A" position

ALPHABET    = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(//)
ROTOR_1     = "EKMFLGDQVZNTOWYHXUSPAIBRCJ".split(//)
ROTOR_2     = "AJDKSIRUXBLHWTMCQGZNPYFVOE".split(//)
ROTOR_3     = "BDFHJLCPRTXVZNYEIWGAKMUSQO".split(//)
REFLECTOR_B = "YRUHQSLDPXNGOKMIEBFZCWVJAT".split(//)

class Enigma
  def initialize(left, middle, right, refl)
    @r_left      = Hash[ALPHABET.zip(left)]
    @r_left_inv  = Hash[@r_left.values.zip(@r_left.keys)]
    @r_mid       = Hash[ALPHABET.zip(middle)]
    @r_mid_inv   = Hash[@r_mid.values.zip(@r_mid.keys)]
    @r_right     = Hash[ALPHABET.zip(right)]
    @r_right_inv = Hash[@r_right.values.zip(@r_right.keys)]
    @reflector   = Hash[ALPHABET.zip(refl)]
  end

  def encode(input)
    output = @r_right[input]      # 1. right rotor encodes input
    output = @r_mid[output]       # 2. middle rotor encodes right rotor output
    output = @r_left[output]      # 3. left rotor encodes middle rotor output
    output = @reflector[output]   # 4. reflector encodes left rotor output
    output = @r_left_inv[output]  # 5. left rotor inversely encodes reflected output
    output = @r_mid_inv[output]   # 6. middle rotor inversely encodes left rotor output
    output = @r_right_inv[output] # 7. right rotor inversely encodes middle rotor output
    output
  end
end

#
# RUN PROGRAM
#
enigma = Enigma.new(ROTOR_1, ROTOR_2, ROTOR_3, REFLECTOR_B)
ALPHABET.each { |letter|
  puts "#{letter} => #{enigma.encode(letter)}"
}
