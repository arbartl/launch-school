class Cat
  attr_accessor :name
  COLOR = 'black'

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello, I'm #{name}. I'm a #{COLOR} cat!"
  end

end

kitty = Cat.new('Sophie')
kitty.greet