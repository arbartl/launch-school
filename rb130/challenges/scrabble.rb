class Scrabble
  def initialize(word)
    @word = word if valid?(word)
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  def score
    return 0 unless @word
    points_proc = method(:to_points).to_proc
    @word.chars.map(&points_proc).reduce(&:+)
  end

  def to_points(char)
    case char.upcase
    when 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' then 1
    when 'D', 'G' then 2
    when 'B', 'C', 'M', 'P' then 3
    when 'F', 'H', 'V', 'W', 'Y' then 4
    when 'K' then 5
    when 'J', 'X' then 8
    when 'Q', 'Z' then 10
    end
  end

  def valid?(word)
    word && word.match?(/^[A-Za-z]+$/)
  end
end