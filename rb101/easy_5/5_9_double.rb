def crunch(str)
  return_str = ''
  current_char_index = 0
  comparison_char_index = 0

  until current_char_index == str.length
    comparison_char_index += 1
    if str[current_char_index] == str[comparison_char_index]
      next
    else
      return_str << str[current_char_index]
      current_char_index = comparison_char_index
    end
  end
  return_str
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''