def time_of_day(int)
  hours = ""
  minutes = ""

  if int >= 0
    until int < 1440
      int -= 1440
    end
    hours = (int / 60).to_s
    minutes = (int % 60).to_s
  else
    until int > -1440
      int += 1440
    end
    hours = (23 - (int / -60)).to_s
    minutes = (60 + (int % -60)).to_s
  end
  "%02d:%02d" % [hours, minutes]
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"