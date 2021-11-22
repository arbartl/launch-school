# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

lowest_age = nil

ages.each do |_, age|
  lowest_age ||= age
  lowest_age = age if age < lowest_age
end

p lowest_age

# Alternate solution
# ages.values.min