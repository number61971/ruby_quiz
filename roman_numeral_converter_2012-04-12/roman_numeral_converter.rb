#!/usr/bin/env ruby

#
# Roman-to-Arabic conversions
#
Rthousands = {
  ''    => 0,
  'M'   => 1000,
  'MM'  => 2000,
  'MMM' => 3000
}
Rhundreds = {
  ''     => 0,
  'C'    => 100,
  'CC'   => 200,
  'CCC'  => 300,
  'CD'   => 400,
  'D'    => 500,
  'DC'   => 600,
  'DCC'  => 700,
  'DCCC' => 800,
  'CM'   => 900
}
Rtens = {
  ''     => 0,
  'X'    => 10,
  'XX'   => 20,
  'XXX'  => 30,
  'XL'   => 40,
  'L'    => 50,
  'LX'   => 60,
  'LXX'  => 70,
  'LXXX' => 80,
  'XC'   => 90
}
Rones = {
  ''     => 0,
  'I'    => 1,
  'II'   => 2,
  'III'  => 3,
  'IV'   => 4,
  'V'    => 5,
  'VI'   => 6,
  'VII'  => 7,
  'VIII' => 8,
  'IX'   => 9
}

#
# Arabic-to-Roman conversions
#
Athousands = Hash[ Rthousands.to_a.collect{ |item| [item[1].to_s[0], item[0]] } ]
Ahundreds  = Hash[ Rhundreds.to_a.collect{ |item| [item[1].to_s[0], item[0]] } ]
Atens      = Hash[ Rtens.to_a.collect{ |item| [item[1].to_s[0], item[0]] } ]
Aones      = Hash[ Rones.to_a.collect{ |item| [item[1].to_s, item[0]] } ]

#
# Number converter function
#
def convert(n)
  if n.match(/\d/)
    # decimal input
    if n.to_i > 3999
      raise "#{n} cannot be converted to a Roman numeral (it is larger than 3999)"
    end
    conversions = [Aones, Atens, Ahundreds, Athousands]
    result = []
    for d in n.reverse.chars do
      converter = conversions.shift
      result.push(converter[d])
    end
    result.reverse.join('')
  else
    # roman input
    roman = /(M{0,3})(C{0,3}[DM]?|DC{0,3})?(X{0,3}[LC]?|LX{0,3})?(I{0,3}[VX]?|VI{0,3})?/
    m = n.match(roman)
    if m[0] != ''
      result = 0
      result += Rthousands[m[1]]
      result += Rhundreds[m[2]]
      result += Rtens[m[3]]
      result += Rones[m[4]]
    else
      raise "'#{n}' is not a valid Roman numeral"
    end
  end

end


if __FILE__ == $0
  ARGF.each do |line|
    puts convert(line.strip)
  end
end
