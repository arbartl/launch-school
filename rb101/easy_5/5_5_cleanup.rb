def cleanup(str)
  str.gsub(/[^a-z]/, ' ').squeeze
end

p cleanup("---what's my +*& line?") == ' what s my line '
p cleanup("$2-thi==s is4  a&&test!") == ' thi s is a test '