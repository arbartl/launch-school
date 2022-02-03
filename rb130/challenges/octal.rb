class Octal
  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 if @number.chars.any? { |char| char.match(/[^0-7]/) }
    @number.to_i.digits.map.with_index do |digit, ind|
      digit * (8**ind)
    end.reduce(&:+)
  end
end