# def running_total(arr)
#   totals = []
#   arr.each_with_index do |el, ind|
#     totals << arr[0, ind+1].sum
#   end
#   totals
# end

def running_total(arr)
  arr.each_with_object([]) { |el, a| a << arr[0, arr.index(el)+1].sum }
end

p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []