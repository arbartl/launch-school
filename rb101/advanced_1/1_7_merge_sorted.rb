def merge(arr1, arr2)
  arr1 = arr1.dup
  arr2 = arr2.dup
  merged_arr = []

  until arr1.empty? || arr2.empty?
    case arr1.first <=> arr2.first
    when -1
      merged_arr << arr1.shift
    when 0
      merged_arr << arr1.shift
    when 1
      merged_arr << arr2.shift
    end
  end

  arr1.empty? ? merged_arr += arr2 : merged_arr += arr1
  merged_arr
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]