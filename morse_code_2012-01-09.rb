#!/usr/bin/env ruby

# 1. The length of a dot is one unit
# 2. A dash is three units.
# 3. The space between parts of the same letter is one unit.
# 4. The space between letters is three units.
# 5. The space between words is seven units.

MORSE_CODE = {
  'A' => '.-',
  'B' => '-...',
  'C' => '-.-.',
  'D' => '-..',
  'E' => '.',
  'F' => '..-.',
  'G' => '--.',
  'H' => '....',
  'I' => '..',
  'J' => '.---',
  'K' => '-.-',
  'L' => '.-..',
  'M' => '--',
  'N' => '-.',
  'O' => '---',
  'P' => '.--.',
  'Q' => '--.-',
  'R' => '.-.',
  'S' => '...',
  'T' => '-',
  'U' => '..-',
  'V' => '...-',
  'W' => '.--',
  'X' => '-..-',
  'Y' => '-.--',
  'Z' => '--..',
  '1' => '.----',
  '2' => '..---',
  '3' => '...--',
  '4' => '....-',
  '5' => '.....',
  '6' => '-....',
  '7' => '--...',
  '8' => '---..',
  '9' => '----.',
  '0' => '-----',
  ' ' => '  ',
}


MORSE_SOUNDS = {
  '.' => 'afplay "/Users/damon/Music/iTunes/iTunes Media/Tones/morse_dot.m4r"',
  '-' => 'afplay "/Users/damon/Music/iTunes/iTunes Media/Tones/morse_dash.m4r"',
}


class TextConverter
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  def to_morse
    text.each_char do |char|
      morse = MORSE_CODE[char.upcase]
      if morse
        morse.each_char do |m|
          system MORSE_SOUNDS[m] if m != ' '
          print "#{m} "
          m == ' ' ? sleep(0.4) : sleep(0.1)
        end
        print "  " 
        sleep(0.3)
      end
    end
  end
end


if __FILE__ == $0
  ARGF.each_line do |line|
    puts line
    t = TextConverter.new(line.strip)
    t.to_morse
  end
  puts
end
