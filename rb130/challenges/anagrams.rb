class Anagram
  def initialize(word)
    @word = word
  end

  def match(arr)
    arr.select do |comp_word|
      char_map(comp_word) == char_map(@word) && comp_word.downcase != @word.downcase
    end
  end

  private

  def char_map(comp_word)
    comp_word.each_char.with_object(Hash.new(0)) do |char, hash|
      hash[char.downcase] += 1
    end
  end
end