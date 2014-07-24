require 'best_flights'

describe "Best flights" do 
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 540, :arr => 600, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 690, :arr => 810, :price => 100.00)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "Z", :dep => 600, :arr => 720, :price => 300.00)}
	let(:case_one){[flight_one, flight_two, flight_three]}
	
	it "gets the cheapest flight if they're equally cheap" do
		best_flight = BestFlights.get_cheapest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end

	it "gets the fastest flight" do
		best_flight = BestFlights.get_fastest_flight(case_one)
		expect(best_flight).to eq(flight_one)
	end
end