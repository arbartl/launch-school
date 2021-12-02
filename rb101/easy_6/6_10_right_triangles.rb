def triangle(int)
  stars = 1
  int.times do
    str = '*' * stars
    puts str.rjust(int)
    stars += 1
  end
end

triangle(5)
triangle(9)