class Mammal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

end

class Dog < Mammal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Mammal
  def speak
    'meow!'
  end

end

