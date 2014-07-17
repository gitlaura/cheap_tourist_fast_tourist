require 'runner'

describe "Runner" do 
	let(:file) {"sample-input.txt"}
	let(:departure_city) {"A"}
	let(:arrival_city) {"Z"}

	it "gets the cases from the flight parser" do 
		expect(File).to receive(:open)
		expect(FlightRouteCalculator).to receive(:get_cases) {[1, 1]}
		expect(FlightRouteCalculator).to receive(:find_all_flight_paths).twice
		expect(FlightRouteCalculator).to receive(:get_cheapest_flight).twice
		expect(FlightRouteCalculator).to receive(:get_fastest_flight).twice
		expect(FlightRouteCalculator).to receive(:get_print_format).twice
		expect(Runner).to receive(:write_to_file).twice
		Runner.run_flight_route_calculator(file, departure_city, arrival_city)
	end

	it "writes to a file" do 
		temp_output = StringIO.new
		Runner.write_to_file("Hi, I'm Laura", temp_output)
		temp_output.each_line do |line|
			expect(line).to eq("Hi, I'm Laura")
		end
	end
end