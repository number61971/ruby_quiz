#!/usr/bin/env ruby

f = File.new('/usr/share/dict/words')
all_words = f.read()

all_anagrams = []
f.seek(0)
f.readlines.each_with_index do |word, i|
  anagrams = []
  letters = word.strip.downcase.chars.to_a
  if letters.length < 15
    permutations = letters.permutation.to_a.uniq
    puts "#{i} #{word.strip}: #{permutations.length} potential anagrams..."
    permutations.each do |p|
      w = p.join
      re = Regexp.new("^#{w}$", Regexp::IGNORECASE + Regexp::MULTILINE)
      anagrams << w if all_words.match(re)
    end
    all_anagrams << anagrams.sort if anagrams.length > 1
  end
  break if i > 10
end

all_anagrams = all_anagrams.uniq.sort { |a,b| b.length <=> a.length }
all_anagrams.each do |a|
  puts a.inspect
end
