def rotate_array(arr)
  rotated_arr = arr.dup
  rotated_arr << rotated_arr.shift
end


p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']

p x = [1, 2, 3, 4]
p rotate_array(x) == [2, 3, 4, 1]   # => true
p x == [1, 2, 3, 4]                 # => true

def rotate_str(str)
  rotate_array(str.chars).join
end

p rotate_str('This is a test') == 'his is a testT'
p rotate_str('hellO') == 'ellOh'
p rotate_str('') == ''

def rotate_int(int)
  rotate_str(int.to_s).to_i
end

p rotate_int(14563) == 45631
p rotate_int(33) == 33
p rotate_int(3004568) == 45683