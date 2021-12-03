def lights(int)
  lights_on = []
  lights_arr = Array.new(int, 0)
  int.times do |i|
    lights_arr.each_with_index do |el, ind|
      lights_arr[ind] = switch_light(el) if (ind + 1) % (i + 1) == 0
    end
  end

  lights_arr.each_with_index do |el, ind|
    lights_on << (ind+1) if el == 1
  end

  lights_on
end

def switch_light(int)
  int == 0 ? 1 : 0
end
