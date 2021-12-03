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

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917