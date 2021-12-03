def buy_fruit(arr)
  list = []
  arr.each do |sub_arr|
    fruit, quantity = sub_arr
    quantity.times { list << fruit }
  end
  list
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
["apples", "apples", "apples", "orange", "bananas","bananas"]