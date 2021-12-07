WORDS = {
  adjectives: ['quick', 'lazy', 'fat', 'tiny', 'gross', 'smelly'],
  nouns: ['goose', 'cow', 'chair', 'table', 'spoon'],
  verbs: ['jumps', 'gallops', 'smells', 'lifts', 'grunts', 'scares'],
  adverbs: ['sadly', 'easily', 'happily', 'quietly', 'noisiliy']
}

madlib = File.new('madlib.txt')

madlib.readlines.each do |line|
  puts line % { adjective: WORDS[:adjectives].sample, noun: WORDS[:nouns].sample,
               verb: WORDS[:verbs].sample, adverb: WORDS[:adverbs].sample }
end