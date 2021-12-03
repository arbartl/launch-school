# def interleave(arr1, arr2)
#   return_arr = []
#   until arr1.empty?
#       return_arr << arr1.shift
#       return_arr << arr2. shift
#   end
#   return_arr
# end

def interleave(arr1, arr2)
  arr1.zip(arr2).flatten
end


p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']