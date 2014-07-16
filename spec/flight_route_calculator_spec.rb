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
		expect(FlightRouteCalculator).to respond_to(:find_best_flights)
	end

	it "finds the cheapest flight" do 
		best_flight = FlightRouteCalculator.get_cheapest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end

	it "finds the fastest flight" do 
		best_flight = FlightRouteCalculator.get_fastest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end

	it "write to a file" do 
		output_file = FlightRouteCalculator.write_to_file([flight_one, flight_two])
		read_file = File.open(output_file).read
		read_file.each_line do |line|
			expect(line.start_with?("09:00 10:00 100.00")).to eq(true)
		end
	end
end