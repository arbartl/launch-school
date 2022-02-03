class PerfectNumber
  def self.classify(number)
    raise StandardError unless number > 1
    aliquot = sum_of_divisors(number)
    if aliquot < number
      'deficient'
    elsif aliquot == number
      'perfect'
    elsif aliquot > number
      'abundant'
    end
  end

  def self.sum_of_divisors(number)
    (1..number-1).to_a.select { |num| number % num == 0 }.reduce(&:+)
  end
end