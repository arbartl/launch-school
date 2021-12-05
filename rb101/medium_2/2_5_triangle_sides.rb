def triangle(side1, side2, side3)
  sides = [side1, side2, side3].sort
  return :invalid if sides.include?(0) || (sides[0] + sides[1]) < sides[2]
  return :scalene if sides == sides.uniq
  return :equilateral if sides.all?(side1)
  return :isosceles
end

p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid