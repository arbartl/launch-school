def staggered_case(str, first_case='upper')
  upper_or_lower = first_case
  rtn_str = ''
  str.chars do |char|
    if upper_or_lower == 'upper'
      rtn_str << char.upcase
    else
      rtn_str << char.downcase
    end
    next unless /[a-zA-Z]/.match?(char)
    upper_or_lower == 'upper' ? upper_or_lower = 'lower' : upper_or_lower = 'upper'
  end
  rtn_str
end

p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'