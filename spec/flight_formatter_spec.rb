require 'flight_formatter'

describe "Flight formatter" do 
	it "creates the correct flight format" do 
		flight_one = OpenStruct.new(:from => "A", :to => "B", :dep => 540, :arr => 600, :price => 100.00)
		flight_two = OpenStruct.new(:from => "B", :to => "Z", :dep => 690, :arr => 810, :price => 100.00)

		line = FlightFormatter.get_print_format([flight_one, flight_two])
		
		expect(line).to include("9:00 10:00 100.00\n")
	end

	it "formats the correct time" do 
		expect(FlightFormatter.format_time(550)).to eq("09:10")
	end

	it "formats the correct price" do 
		expect(FlightFormatter.format_price(375.2)).to eq("375.20")
	end
end