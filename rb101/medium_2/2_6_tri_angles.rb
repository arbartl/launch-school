def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3]
  return :invalid if angles.include?(0) || angles.sum != 180
  return :right if angles.any?(90)
  return :acute if angles.all? { |angle| angle < 90 }
  return :obtuse if angles.any? { |angle| angle > 90 }
end

p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid