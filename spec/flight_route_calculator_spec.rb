require 'flight_route_calculator'

describe "Flight route calc" do 
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 540, :arr => 600, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 690, :arr => 810, :price => 100.00)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "Z", :dep => 600, :arr => 720, :price => 300.00)}
	let(:case_one){[flight_one, flight_two, flight_three]}

	it "parses text file into cases" do
		cases = FlightRouteCalculator.get_cases("input.txt")
		expect(cases.size).to eq(3)
	end

	it "finds the best flights for each case" do 
		departure_city = "A"
		arrival_city = "Z"

		all_paths = FlightRouteCalculator.find_all_flight_paths(case_one, departure_city, arrival_city)

		expect(all_paths.size).to eq(2)
	end

	it "finds the cheapest flight" do 
		best_flight = FlightRouteCalculator.get_cheapest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end

	it "finds the fastest flight" do 
		best_flight = FlightRouteCalculator.get_fastest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end

	it "formats the flights for print" do 
		line_to_print = FlightRouteCalculator.get_print_format([flight_two, flight_three])
		expect(line_to_print).to include("10:00 12:00 300.00\n\n")
	end
end