def staggered_case(str, first_case='upper')
  upper_or_lower = first_case
  rtn_str = ''
  str.chars do |char|
    if upper_or_lower == 'upper'
      rtn_str << char.upcase
      upper_or_lower = 'lower'
    else
      rtn_str << char.downcase
      upper_or_lower = 'upper'
    end
  end
  rtn_str
end

p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'