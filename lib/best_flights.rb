class BestFlights
	class << self
		def get_cheapest_flight(all_flight_paths)
			@lowest_price = nil
			all_flight_paths.each do |flight|
				if @lowest_price.nil? || flight.price < @lowest_price
					@best_flight = flight
					@lowest_price = flight.price
				elsif @lowest_price == flight.price
					@best_flight = get_fastest_flight([@best_flight, flight])
				end
			end
			@best_flight
		end

		def get_fastest_flight(all_flight_paths)
			@shortest_length = nil
			all_flight_paths.each do |flight|
				@length = flight.arr - flight.dep
				if @shortest_length.nil? || @length < @shortest_length
					@best_flight = flight
					@shortest_length = @length
				elsif @shortest_length == @length
					@best_flight = get_cheapest_flight([@best_flight, flight])
				end
			end
			@best_flight
		end
	end
end