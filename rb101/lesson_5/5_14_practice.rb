# Given this data structure write some code to return an array containing the colors
# of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# Return value should look like this: [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

arr = []

hsh.values.each do |details|
  if details[:type] == 'fruit'
    arr << details[:colors].map { |el| el.capitalize }
  elsif details[:type] == 'vegetable'
    arr << details[:size].upcase
  end
end

p arr