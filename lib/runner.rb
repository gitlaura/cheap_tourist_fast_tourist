require_relative 'flight_route_calculator.rb'

class Runner
	class << self
		def run_flight_route_calculator(flights_to_parse, departure_city, arrival_city)
			output_file = File.open("output.txt","w")
			cases = FlightRouteCalculator.get_cases(flights_to_parse)
			cases.each do |flight_case|
				flight_paths = FlightRouteCalculator.find_all_flight_paths(flight_case, departure_city, arrival_city)
				cheapest_flight = FlightRouteCalculator.get_cheapest_flight(flight_paths)
				fastest_flight = FlightRouteCalculator.get_fastest_flight(flight_paths)
				line_to_print = FlightRouteCalculator.get_print_format([cheapest_flight, fastest_flight])
				write_to_file(line_to_print,output_file)
			end
			output_file
		end

		def write_to_file(line_to_print, file)
			file.write(line_to_print) 
		end
	end
end