# original

# def swap(str)
#   str_arr = str.split(' ')
#   reverse_arr = str_arr.map do |word|
#     if word.length == 1
#       word
#     elsif word.length == 2
#       word.reverse
#     else
#       first_char = word[0]
#       last_char = word[-1]
#       middle = word[1, word.length-2]
#       last_char + middle + first_char
#     end
#   end
#   reverse_str = reverse_arr.join(' ')
#   reverse_str
# end

# refactor

def swap(str)
  result = str.split.map do |word|
    swap_first_and_last(word)
  end

  result.join(' ')
end

def swap_first_and_last(word)
  word[0], word[-1] = word[-1], word[0]
  word
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'
p swap('This is a test case') == 'shiT si a test easc'