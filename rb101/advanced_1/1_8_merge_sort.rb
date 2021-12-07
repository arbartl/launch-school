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

def split_to_nested(arr)
  nested = []
  half = arr.size / 2
  nested << arr.slice(0...half)
  nested << arr.slice(half..)
  nested
end

def merge_sort(arr)
  return arr if arr.size == 1

  sub_arr1, sub_arr2 = split_to_nested(arr)

  sub_arr1, sub_arr2 = merge_sort(sub_arr1), merge_sort(sub_arr2)

  merge(sub_arr1, sub_arr2)
end

p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]