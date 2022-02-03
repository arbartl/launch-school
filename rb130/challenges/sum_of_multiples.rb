class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def self.to(end_num, multiples=[3, 5])
    arr = (multiples.min..end_num-1).to_a
    is_mult = proc { |num| multiples.any? { |mult| num % mult == 0 } }
    sum = arr.select(&is_mult).reduce(&:+)
    sum ? sum : 0
  end

  def to(end_num)
    self.class.to(end_num, @multiples)
  end
end