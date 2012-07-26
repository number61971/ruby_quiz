#require 'rspec'

=begin
The task is to find the words in the English language 
that form the most number of perfect anagrams, that is, anagrams 
that use the exact same letters in each permutation and are all 
words in the English language. (Not, as Chris Wilson had pointed 
out, anagrams for which all permutations are English words, which 
is a far harder problem.)

An example is the word meat, which has the following anagrams:
  meat mate meta tame team tema

So we have 6 total permutations for that one.

The best way to format output is probably the number of occurances,
followed by the permutations that are words, sorted with the 
highest at the top of the list, for the top 20 anagrams in English. 
   
/usr/share/dict/words is probably the easiest dictionary to use for this.

=end

DICTIONARY = "/usr/share/dict/words"

class Anagrammer
  
  def start( d = DICTIONARY )
    @word_hash = Hash.new
    @word_array = Array.new
    @last_word = ""
    puts "processing words from dictionary #{d}..."
    count = 0
    IO.foreach(d) do |line| 
      process_words(line)
      count = count + 1
    end
    puts "... completed #{count} words"
    process_hash
    process_array
  end

  def clean_word( word )
    return word.strip.chomp.downcase
  end

  def make_key( word )
    key_a = word.chars.to_a.sort
    key = key_a.join("")
    return key
  end

  def process_words( word )
    return if word.downcase == @last_word
    @last_word = word.downcase
    clean = clean_word( word )
    key = make_key( clean )
    if @word_hash.has_key?(key)
      old_words = @word_hash.fetch(key)
      @word_hash[key] = "#{old_words}, #{clean}"
    else
      @word_hash[key] = clean
    end
  end

  def process_hash
    puts "processing the hash"
    @word_hash.each do | key, val |
      words = val.split(',')
      a = [ words.count, val ]
      @word_array << a
    end
  end

  def process_array
    puts "processing the array"
    @word_array.sort_by! do |x|
      x[0].to_i
    end

    word_count = 99
    @word_array.count.downto(@word_array.count-20) do |i| 
      if word_count != @word_array[i-1][0].to_i
        word_count = @word_array[i-1][0].to_i
        puts "The following combinations formed #{word_count} words:"
      end
      puts "   #{@word_array[i-1][1]}"
    end
  end
end


if __FILE__ == $0
  t_start = Time.now
  a = Anagrammer.new
  a.start
  puts "Total computation time: #{Time.now - t_start} seconds"
end

# -------------------------------
#

#describe Anagrammer do
#
#  before do
#    @ana = Anagrammer.new
#  end
#
#  it 'can clean a word' do
#    dw = "\t Applesauce  \n"
#    cw = @ana.clean_word(dw)
#    cw.should == 'applesauce'
#  end
#
#  it 'can generate a word key' do
#    @ana.make_key('applesauce').should == 'aaceelppsu'
#  end
#
#end
