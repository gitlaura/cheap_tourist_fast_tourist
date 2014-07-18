require_relative("all_paths.rb")
require_relative("best_flights.rb")
require_relative("flight_formatter.rb")
require_relative("flight_parser.rb")

class FlightRouteCalculator
	class << self
		def get_cases(file)
			FlightParser.parse(file)
		end

		def find_all_flight_paths(flight_case, departure_city, arrival_city)
			AllPaths.new(flight_case, departure_city, arrival_city).create_paths
		end

		def get_cheapest_flight(all_flight_paths)
			BestFlights.get_cheapest_flight(all_flight_paths)
		end

		def get_fastest_flight(all_flight_paths)
			BestFlights.get_fastest_flight(all_flight_paths)
		end

		def get_print_format(flights)
			FlightFormatter.get_print_format(flights)
		end
	end
end