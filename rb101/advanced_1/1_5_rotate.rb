# [0][0] -> [0][2]
# [0][1] -> [1][2]
# [0][2] -> [2][2]
# 
# [1][0] -> [0][1]
# [1][1] -> [1][1]
# [1][2] -> [2][1]
# 
# [2][0] -> [0][0]
# [2][1] -> [1][0]
# [2][2] -> [2][0]

def rotate90(matrix)
  new_matrix = Array.new
  0.upto(matrix[0].size-1) { |num| new_matrix[num] = Array.new }

  matrix.each_with_index do |row, r_ind|
    row.each_with_index do |el, c_ind|
      new_matrix[c_ind][matrix.size - r_ind - 1] = el
    end
  end

  new_matrix
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2