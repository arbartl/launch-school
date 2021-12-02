def print_in_box(str)
  banner_size = str.length + 2
  banner_heading = ''
  banner_spacing = ''
  banner_size.times { banner_heading << '-' }
  banner_size.times { banner_spacing << ' ' }
  puts('+' + banner_heading + '+')
  puts('|' + banner_spacing + '|')
  puts('| ' + str + ' |')
  puts('|' + banner_spacing + '|')
  puts('+' + banner_heading + '+')
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('This is a test string...')