def balanced?(str)
  bracket_stack = []
  str.chars do |char|
    case char
    when '(', '[', '{'
      bracket_stack << char
    when ')'
      last_stack = bracket_stack.pop
      return false unless last_stack == '('
    when ']'
      last_stack = bracket_stack.pop
      return false unless last_stack == '['
    when '}'
      last_stack = bracket_stack.pop
      return false unless last_stack == '{'
    else
      next
    end
  end
  bracket_stack.empty?
end


p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
p balanced?('Does (this) return {[true]}') == true
p balanced?('This should [return] false}') == false