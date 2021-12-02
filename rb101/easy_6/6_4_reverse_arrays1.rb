def reverse!(arr)
  begin_index = 0
  end_index = -1

  (arr.size / 2).times do
    arr[begin_index], arr[end_index] = arr[end_index], arr[begin_index]
    begin_index += 1
    end_index -= 1
  end
  
  arr
end

list = [1,2,3,4]
result = reverse!(list)
p result == [4, 3, 2, 1] # true
p list == [4, 3, 2, 1] # true
p list.object_id == result.object_id # true

list = %w(a b e d c)
p reverse!(list) == ["c", "d", "e", "b", "a"] # true
p list == ["c", "d", "e", "b", "a"] # true

list = ['abc']
p reverse!(list) == ["abc"] # true
p list == ["abc"] # true

list = []
p reverse!(list) == [] # true
p list == [] # true