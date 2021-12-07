BRACKETS = {
  '{' => '}',
  '[' => ']',
  '(' => ')'
}

def balanced?(str)
  rogue_apostrophes = str.scan(/(')/).count - str.scan(/(\S'\S)/).count
  return false if rogue_apostrophes.odd? || str.scan(/(")/).count.odd?

  bracket_stack = []
  str.chars do |char|
    if BRACKETS.keys.include?(char)
      bracket_stack << char
    elsif BRACKETS.values.include?(char)
      last_stack = bracket_stack.pop
      return false unless last_stack == BRACKETS.key(char)
    end
  end

  bracket_stack.empty?
end

p balanced?('Does (this) return {[true]}') == true
p balanced?('This should [return] false}') == false
p balanced?("This doesn't have a rogue apostrophe.") == true
p balanced?("This (line) does' have a rogue apostrophe.") == false
p balanced?('Sometimes you have "too many"" double quotes.') == false
p balanced?('And sometimes you have "just the right" amount.') == true