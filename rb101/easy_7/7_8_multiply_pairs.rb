def multiply_all_pairs(arr1, arr2)
  mult_arr = []
  arr1.each do |el|
    arr2.each do |el2|
      mult_arr << el * el2
    end
  end
  mult_arr.sort
end


p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]