def century(year)
  century = if year / 100 < 1
              1
            elsif year % 100 == 0
              year / 100
            else
              year / 100 + 1
            end
  century.to_s + suffix(century)
end

def suffix(century)
  return 'th' if (11..19).to_a.include?(century % 100)

  last_digit = century % 10

  suffix = if last_digit == 1
             'st'
           elsif last_digit == 2
             'nd'
           elsif last_digit == 3
             'rd'
           else
             'th'
           end
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'
p century(1890) == '19th'