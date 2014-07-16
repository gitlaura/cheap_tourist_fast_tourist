require 'all_paths'
require 'ostruct'

describe "All paths" do 
	let(:number_of_flights){3}
	let(:flight_one){OpenStruct.new(:from => "A", :to => "B", :dep => 9.00, :arr => 10.00, :price => 100.00)}
	let(:flight_two){OpenStruct.new(:from => "B", :to => "Z", :dep => 11.5, :arr => 13.5, :price => 100.00)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "Z", :dep => 10.00, :arr => 12.00, :price => 300.00)}
	let(:flight_four){OpenStruct.new(:from => "A", :to => "Z", :dep => 9.00, :arr => 13.5, :price => 200.00)}
	let(:flights){[flight_one, flight_two, flight_three]}
	let(:all_paths){[flight_four, flight_three]}
	let(:departure_city){"A"}
	let(:arrival_city){"Z"}
	
	it "responds to create" do 
		final_paths = AllPaths.create(flights, departure_city, arrival_city)
		expect(final_paths).to eq(all_paths)
	end
end