# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |member, value|
  value.each do |word|
    word.chars { |char| puts char if %w(a e i o u A E I O U).include?(char) }
  end
end
