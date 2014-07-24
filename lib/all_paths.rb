require 'ostruct'

class AllPaths
	def initialize(flights, departure_city, arrival_city)
		@flights = flights
		@departure_city = departure_city
		@arrival_city = arrival_city
		@final_paths = []
	end

	def create_paths
		@departure_city_groups = group_flights_by_departure_city
		@departure_city_groups[@departure_city.to_sym].each do |flight_from_dep_city|
			if flight_from_dep_city.to == @arrival_city
				@final_paths << flight_from_dep_city
			else
				@current_path = create_new_path(flight_from_dep_city)
				@path_attributes = reset_path_attributes(flight_from_dep_city)
				update_current_path
			end
		end
		@final_paths
	end

	def group_flights_by_departure_city
		departure_city_groups = {}
		@flights.each do |flight|
			new_from = flight.from.to_sym
			departure_city_groups[new_from] ||= []
			departure_city_groups[new_from] << flight
		end
		departure_city_groups
	end

	def create_new_path(flight)
		OpenStruct.new(:from => @departure_city, :to => nil, :dep => flight.dep, :arr => nil, :price => nil)
	end

	def reset_path_attributes(flight)
		path_attributes = {}
		path_attributes[:prices], path_attributes[:arrival_times], path_attributes[:arrival_cities] = [], [], []
		path_attributes[:prices] << flight.price
		path_attributes[:arrival_times] << flight.arr
		path_attributes[:arrival_cities] << flight.to
		path_attributes
	end

	def update_current_path(new_path_level = false)
		new_dep_city = @path_attributes[:arrival_cities].last.to_sym
		@departure_city_groups[new_dep_city].each do |possible_flight|
			if new_path_level == false 
				remove_attributes_from_last_flight if @path_attributes[:arrival_cities].size > 1
			end
			if valid_next_flight?(possible_flight)
				update_path_attributes(possible_flight)
				if possible_flight.to == @arrival_city
					add_attributes_to_path
					add_current_path_to_final_paths
					remove_attributes_from_last_flight
					next
				end
				update_current_path(true)
			end
		end
	end	

	def valid_next_flight?(possible_flight)
		@path_attributes[:arrival_times].last < possible_flight.dep && possible_flight.to > possible_flight.from
	end

	def update_path_attributes(possible_flight)
		@path_attributes[:prices] << possible_flight.price		
		@path_attributes[:arrival_times] << possible_flight.arr	
		@path_attributes[:arrival_cities] << possible_flight.to	
	end

	def add_attributes_to_path
		@current_path.price = @path_attributes[:prices].reduce(:+)
		@current_path.arr = @path_attributes[:arrival_times].last
		@current_path.to = @path_attributes[:arrival_cities].last
	end

	def	remove_attributes_from_last_flight
		@path_attributes[:prices].pop
		@path_attributes[:arrival_times].pop
		@path_attributes[:arrival_cities].pop
	end

	def add_current_path_to_final_paths
		end_path = @current_path.dup
		@final_paths << end_path
	end
end