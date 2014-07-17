require 'flight_route_calculator'

describe "Flight route calc" do 
	let(:file){"sample-input.txt"}
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 540, :arr => 600, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 690, :arr => 810, :price => 100.00)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "Z", :dep => 600, :arr => 720, :price => 300.00)}
	let(:case_one){[flight_one, flight_two, flight_three]}
	let(:departure_city){"A"}
	let(:arrival_city){"Z"}

	it "parses text file into cases" do
		cases = FlightRouteCalculator.get_cases(file)
		expect(cases.size).to eq(2)
	end

	it "finds the best flights for each case" do 
		expect(FlightRouteCalculator).to respond_to(:find_all_flight_paths)
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