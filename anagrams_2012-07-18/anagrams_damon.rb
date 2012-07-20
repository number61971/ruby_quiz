#!/usr/bin/env ruby

$dictionary_words = []
File.new('/usr/share/dict/words', 'r:UTF-8').readlines.each do |line|
  $dictionary_words << line.strip
end

$anagrams_by_sorthash = Hash.new { |hash,key| hash[key] = [] }
$dictionary_words.each do |word|
  sorthash = word.downcase.chars.to_a.sort.join('')
  $anagrams_by_sorthash[sorthash] << word
end


def find_anagrams(word)
  if not $dictionary_words.include?(word)
    if $dictionary_words.include?(word.downcase)
      word.downcase!
    elsif $dictionary_words.include?(word.capitalize)
      word.capitalize!
    else
      return ['Word not in dictionary']
    end
  end

  anagrams = $anagrams_by_sorthash[ word.downcase.chars.to_a.sort.join('') ]
  anagrams.delete(word)
  anagrams
end

if __FILE__ == $0
  puts 'Usage: anagrams.rb <word> [<word> ...]' if ARGV.length == 0
  ARGV.each do |word|
    anagrams = find_anagrams(word)
    puts "#{word}: #{anagrams.join(', ')}"
  end
end
