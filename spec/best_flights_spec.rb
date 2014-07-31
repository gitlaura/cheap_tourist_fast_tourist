require 'best_flights'

describe "Best flights" do 
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 100, :arr => 300, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 100, :arr => 400, :price => 300.00)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "Z", :dep => 100, :arr => 200, :price => 300.00)}
	let(:flight_four){OpenStruct.new(:from => "A", :to => "Z", :dep => 100, :arr => 200, :price => 100.00)}

	it "gets the cheapest flight" do
		best_flight = BestFlights.get_cheapest_flight([flight_one, flight_two])
		expect(best_flight).to eq(flight_one)
	end

	it "gets the fastest flight" do
		best_flight = BestFlights.get_fastest_flight([flight_one, flight_three])
		expect(best_flight).to eq(flight_three)
	end
	
	it "gets the fastest flight if they're equally cheap" do
		best_flight = BestFlights.get_cheapest_flight([flight_one, flight_four])
		expect(best_flight).to eq(flight_four)
	end

	it "gets the cheapest flight if they're equally fast" do
		best_flight = BestFlights.get_fastest_flight([flight_three, flight_four])
		expect(best_flight).to eq(flight_four)
	end
end