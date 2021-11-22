# In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Find the index of the first name that starts with "Be"

# name_index = nil
# 
# flintstones.each_with_index { |name, index| name_index ||= index if name.start_with?("Be") }
# 
# p name_index

p flintstones.index { |name| name.start_with?("Be") }