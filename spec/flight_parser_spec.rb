require 'flight_parser'

describe "Flight parser" do 
	it "parses flights" do
		cases = FlightParser.parse("sample-input.txt") 

		expect(cases.size).to eq(2)
		expect(cases[0].size).to eq(3)
	end

	it "creates a flight object" do
		new_flight = FlightParser.create_flight("A", "Z", "9:00", "10:00", "100.00")

		expect(new_flight.from).to eq("A")
		expect(new_flight.to).to eq("Z")
		expect(new_flight.dep).to eq(540)
		expect(new_flight.price).to eq(100.00)
	end

	it "turns time into numbers" do 
		number = FlightParser.to_number("9:15")
		expect(number).to eq(555)
	end

	it "checks for empty lines" do 
		result = FlightParser.empty_line?("\n", 3)
		expect(result).to eq(true)
	end

	it "checks for the case number" do 
		result = FlightParser.number_of_cases?("5")
		expect(result).to eq(true)
	end
end