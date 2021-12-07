def bubble_sort!(arr)
  length = arr.length - 2
  loop do
    changes = 0
    index = 0

    while index <= length do
      p arr
      if (arr[index] <=> arr[index + 1]) == 1
        arr[index], arr[index + 1] = arr[index + 1], arr[index]
        changes += 1
      end

      index += 1
    end

    break if changes == 0
    changes = 0
    length -= 1
  end
  arr
end


array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)