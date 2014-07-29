class BestFlights
	class << self
		def get_cheapest_flight(all_flight_paths)
			cheapest_flight = all_flight_paths.min_by {|path| path.price}
			cheapest_flights = all_flight_paths.select {|path| path.price == cheapest_flight.price}
			if cheapest_flights.size > 1
				best_flight = get_fastest_flight(cheapest_flights)
			else
				best_flight = cheapest_flights[0]
			end
			best_flight
		end

		def get_fastest_flight(all_flight_paths)
			shortest_flight = all_flight_paths.min_by {|path| path.arr - path.dep}
			shortest_length = shortest_flight.arr - shortest_flight.dep
			shortest_flights = all_flight_paths.select {|path| (path.arr - path.dep) == shortest_length}
			if shortest_flights.size > 1
				best_flight = get_cheapest_flight(shortest_flights)
			else
				best_flight = shortest_flights[0]
			end
			best_flight
		end
	end
end