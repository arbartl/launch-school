def sum_square_difference(int)
  sum_squared = (1..int).to_a.sum ** 2

  squared_sums = 0
  1.upto(int) { |num| squared_sums += num ** 2 }

  sum_squared - squared_sums
end


p sum_square_difference(3) == 22
# -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150