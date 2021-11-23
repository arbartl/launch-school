# Given this nested Hash:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# figure out the total age of just the male members of the family.

total_age = 0

# male = munsters.select do |member|
#   munsters[member]["gender"] == "male"
# end
# 
# male.each do |key, value|
#   total_age += male[key]["age"]
# end
# 
# p total_age

# Alternate solution

munsters.each_value do |details|
  total_age += details["age"] if details["gender"] == "male"
end

p total_age