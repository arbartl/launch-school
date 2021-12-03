def group_anagrams(arr)
  anagrams = []
  arr.each do |word|
    anagram = []
    arr.each do |word2|
      next if word == word2
      anagram << word2 if word.chars.sort.join('') == word2.chars.sort.join('')
    end
    anagram << word if !anagram.empty?
    anagrams << anagram if !anagram.empty?
  end

  anagrams.each do |group|
    group.sort!
  end

  anagrams.uniq.each do |group|
    p group
  end
  
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
  'flow', 'neon']

group_anagrams(words)