def swap_name(str)
  first, last = str.split(' ')
  last + ', ' + first
end

p swap_name('Joe Roberts') == 'Roberts, Joe'