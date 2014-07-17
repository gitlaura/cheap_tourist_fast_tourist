require 'flight_formatter'

describe "Flight formatter" do 
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 540, :arr => 600, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 690, :arr => 810, :price => 100.00)}

	it "creates the correct flight format" do 
		line = FlightFormatter.get_print_format([flight_one, flight_two])
		expect(line).to include("9:00 10:00 100.00\n")
	end
end