def halvsies(arr)
  first = []
  last = []
  until arr.empty?
    first << arr.shift
    break if arr.empty?
    last.prepend(arr.pop)
  end
  [first, last]
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]