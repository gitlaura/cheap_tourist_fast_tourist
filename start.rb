require_relative 'lib/runner.rb'

flights_to_parse = "input.txt"
departure_city = "A"
arrival_city = "Z"

Runner.run_flight_route_calculator(flights_to_parse,departure_city,arrival_city)