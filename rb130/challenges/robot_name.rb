class Robot
  attr_reader :name
  
  @@active_robots = []

  def initialize
    @name = generate_new_name
    @@active_robots << name
  end

  def generate_new_name
    new_name = ''
    2.times { new_name << ('A'..'Z').to_a.sample }
    3.times { new_name << ('0'..'9').to_a.sample }
    @@active_robots.include?(new_name) ? generate_new_name : new_name
  end

  def reset
    @@active_robots.delete_if { |el| el == @name }
    @name = generate_new_name
    @@active_robots << @name
  end
end
