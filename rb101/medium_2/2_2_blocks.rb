BLOCKS = {
  'b' => 'o', 'x' => 'k', 'd' => 'q', 'c' => 'p', 'n' => 'a',
  'g' => 't', 'r' => 'e', 'f' => 's', 'j' => 'w', 'h' => 'u',
  'v' => 'i', 'l' => 'y', 'z' => 'm'
}

def block_word?(str)
  str.downcase.chars do |letter|
    return false if str.downcase.chars.include?(BLOCKS[letter])
  end
  true
end