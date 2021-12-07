def star(int)
  center = int/2
  arr = Array.new(int, '')
  arr[center] = '*' * int
  outside_space = 0
  inside_space = center - 1

  0.upto(center-1) do |line|
    arr[line] = arr[-1-line] = ' ' * outside_space +
                               '*' +
                               ' ' * inside_space +
                               '*' +
                               ' ' * inside_space +
                               '*' +
                               ' ' * outside_space
    outside_space += 1
    inside_space -= 1
  end

  arr.each { |line| puts line}

end

star(21)