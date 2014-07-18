require 'all_paths'
require 'ostruct'

describe "All paths" do 
	let(:number_of_flights){7}
	let(:flight_one){OpenStruct.new(	:from => "A", :to => "B", :dep => 480, :arr => 540, :price => 50.0)}
	let(:flight_two){OpenStruct.new(	:from => "A", :to => "B", :dep => 720, :arr => 780, :price => 300.0)}
	let(:flight_three){OpenStruct.new(:from => "A", :to => "C", :dep => 840, :arr => 930, :price => 175.0)}
	let(:flight_four){OpenStruct.new( :from => "B", :to => "C", :dep => 600, :arr => 660, :price => 75.0)}
	let(:flight_five){OpenStruct.new( :from => "B", :to => "Z", :dep => 900, :arr => 990, :price => 250.0)}
	let(:flight_six){OpenStruct.new(  :from => "C", :to => "B", :dep => 945, :arr => 1005,:price => 50.0)}
	let(:flight_seven){OpenStruct.new(:from => "C", :to => "Z", :dep => 960, :arr => 1140,:price => 100.0)}

	let(:path_one){OpenStruct.new(    :from => "A", :to => "Z", :dep => 480, :arr => 1140,:price => 225.0)}
	let(:path_two){OpenStruct.new(    :from => "A", :to => "Z", :dep => 480, :arr => 990,	:price => 300.0)}
	let(:path_three){OpenStruct.new(	:from => "A", :to => "Z", :dep => 720, :arr => 990,	:price => 550.0)}
	let(:path_four){OpenStruct.new(		:from => "A", :to => "Z", :dep => 840, :arr => 1140,:price => 275.0)}

	let(:flights){[flight_one, flight_two, flight_three, flight_four, flight_five, flight_six, flight_seven]}
	let(:all_paths){[path_one, path_two, path_three, path_four]}
	let(:departure_city){"A"}
	let(:arrival_city){"Z"}

	let(:all_paths_class) {AllPaths.new(flights, departure_city, arrival_city)}

	it "creates a hash with all from cities" do 
		all_froms = all_paths_class.group_flights_by_from_city
		expect(all_froms[:A]).to eq([flight_one, flight_two, flight_three])
	end

	it "creates the correct paths" do 
		final_paths = all_paths_class.create_paths
		expect(final_paths).to eq(all_paths)
	end
end