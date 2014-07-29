class BestFlights
	class << self
		def get_cheapest_flight(all_flight_paths)
			cheapest_path = all_flight_paths.min_by {|path| path.price}
			cheapest_paths = all_flight_paths.select {|path| path.price == cheapest_path.price}
			if cheapest_paths.size > 1
				best_flight = get_fastest_flight(cheapest_paths)
			else
				best_flight = cheapest_paths[0]
			end
			best_flight
		end

		def get_fastest_flight(all_flight_paths)
			shortest_path = all_flight_paths.min_by {|path| path.arr - path.dep}
			shortest_length = shortest_path.arr - shortest_path.dep
			shortest_paths = all_flight_paths.select {|path| (path.arr - path.dep) == shortest_length}
			if shortest_paths.size > 1
				best_flight = get_cheapest_flight(shortest_paths)
			else
				best_flight = shortest_paths[0]
			end
			best_flight
		end
	end
end