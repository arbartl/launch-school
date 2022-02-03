class Series
  def initialize(string)
    @string = string
  end

  def slices(size)
    raise ArgumentError if size > @string.size
    result = []
    idx = 0
    while idx <= @string.size - size
      result << @string.chars[idx, size].map(&:to_i)
      idx += 1
    end
    result
  end
end