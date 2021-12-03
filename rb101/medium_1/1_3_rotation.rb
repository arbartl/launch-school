def rotate_array(arr)
  rotated_arr = arr.dup
  rotated_arr << rotated_arr.shift
end

def rotate_str(str)
  rotate_array(str.chars).join
end

def rotate_int(int)
  rotate_str(int.to_s).to_i
end

def rotate_rightmost_digits(int, digits)
  slice_left, slice_right = int.to_s[0...-digits], int.to_s[-digits..-1]
  (slice_left + rotate_str(slice_right)).to_i
end

def max_rotation(int)
  size = int.to_s.size
  while size > 0 do
    int = rotate_rightmost_digits(int, size)
    size -= 1
  end
  int
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845