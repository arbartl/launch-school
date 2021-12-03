def multiply_list(arr1, arr2)
  mult_arr = []
  arr1.each_with_index { |el, ind| mult_arr << el * arr2[ind] }
  mult_arr
end

p multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]