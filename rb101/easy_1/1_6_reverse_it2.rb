=begin
Write a method that takes one argument, a string containing one or more words, and returns the given string with words that contain five or more characters reversed. Each string
will consist of only letters and spaces. Spaces should be included only when more than one word is present.

Mental Model:
Given a string of words, convert the string into an array of individual words. Iterate through the array of words. If a word is 5 or more characters long, reverse that word and replace the
original with the reversed word. Return the string with the reversed words.


=end

def reverse_words(string)
  arr = string.split

  arr.each_with_index { |word, index| arr[index] = word.reverse if word.length >= 5 }

  arr.join(' ')
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS