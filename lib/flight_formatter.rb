class FlightFormatter
	def self.get_print_format(flights)
			@line_to_print = ""
			flights.each do |flight|
				departure_hour = (flight.dep / 60).to_s
				departure_hour = "0#{departure_hour}" if departure_hour.to_i < 10
				departure_min = (flight.dep % 60).to_s
				departure_min = "0#{departure_min}" if departure_min.to_i < 10
				departure_time = "#{departure_hour}:#{departure_min}"
				arrival_hour = (flight.arr / 60).to_s
				arrival_hour = "0#{arrival_hour}" if arrival_hour.to_i < 10
				arrival_min = (flight.arr % 60).to_s
				arrival_min = "0#{arrival_min}" if arrival_min.to_i < 10
				arrival_time = "#{arrival_hour}:#{arrival_min}"
				price = flight.price
				@line_to_print << "#{departure_time} #{arrival_time} #{price}0\n"
			end
			@line_to_print << "\n"
		end
end