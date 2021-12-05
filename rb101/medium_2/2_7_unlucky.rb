require 'date'

def friday_13th(year)
  unlucky = 0
  12.times do |month|
    unlucky += 1 if Date.new(year, month+1, 13).friday?
  end
  unlucky
end

p friday_13th(2015) == 3
p friday_13th(1986) == 1
p friday_13th(2019) == 2