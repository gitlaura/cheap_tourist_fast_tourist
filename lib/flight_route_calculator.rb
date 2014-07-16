require_relative 'flight_parser.rb'
require_relative 'all_paths.rb'

class FlightRouteCalculator
	class << self
		def get_cases(file)
			FlightParser.parse(file)
		end

		def find_best_flights(flight_cases, departure_city, arrival_city)
			flight_cases.each do |flight_case|
				all_flight_paths = AllPaths.create(flight_case, departure_city, arrival_city)
				cheapest_flight = get_cheapest_flight(all_flight_paths)
				fastest_flight = get_fastest_flight(all_flight_paths)
				write_to_file([cheapest_flight, fastest_flight])
			end
		end

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

		def write_to_file(flights)
			file = File.open("output.txt", "w")
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
				line_to_print = "#{departure_time} #{arrival_time} #{price}0"
				file.write("#{line_to_print}\n\n") 
			end
			file
		end
	end
end