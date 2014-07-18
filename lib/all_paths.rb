require 'ostruct'

class AllPaths

		def initialize(flights, departure_city, arrival_city)
			@flights = flights
			@departure_city = departure_city
			@arrival_city = arrival_city
			@final_paths = []
		end

		def create_paths
			from_city_groups = group_flights_by_from_city
			from_city_groups[@departure_city.to_sym].each do |flight_from_dep_city|
				if flight_from_dep_city.to == @arrival_city
					@final_paths << flight_from_dep_city
				else
					@current_path = create_new_path(flight_from_dep_city)
					reset_price(flight_from_dep_city)
					update_current_path(flight_from_dep_city, from_city_groups)
				end
			end
			@final_paths
		end

		def group_flights_by_from_city
			from_city_groups = {}
			@flights.each do |flight|
				new_from = flight.from.to_sym
				from_city_groups[new_from] = [] if from_city_groups[new_from].nil?
				from_city_groups[new_from] << flight
			end
			from_city_groups
		end

		private

		def create_new_path(flight)
			OpenStruct.new(:from => @departure_city, :to => flight.to, :dep => flight.dep, :arr => flight.arr, :price => nil)
		end

		def reset_price(flight)
			@prices = []
			@prices << flight.price
		end

		def update_current_path(current_flight, from_city_groups)
			new_from_city = current_flight.to.to_sym
			from_city_groups[new_from_city].each do |possible_flight|
				if valid_next_flight?(current_flight, possible_flight)
					update_path(possible_flight)
					update_price(possible_flight)
					if @current_path.to == @arrival_city
						add_prices_to_path
						reset_to_price_from_city
						add_current_path_to_final_paths
						return @final_paths
					end
					update_current_path(@current_path, from_city_groups)
				end
			end
		end	

		def valid_next_flight?(current_flight, possible_flight)
			current_flight.to == possible_flight.from && current_flight.arr < possible_flight.dep && possible_flight.to > possible_flight.from
		end

		def update_path(possible_flight)
			@current_path.to, @current_path.arr = possible_flight.to, possible_flight.arr
		end

		def update_price(possible_flight)
			@prices << possible_flight.price		
		end

		def add_prices_to_path
			@current_path.price = @prices.reduce(:+)
		end

		def reset_to_price_from_city
			@prices = [@prices[0]]
		end

		def add_current_path_to_final_paths
			end_path = @current_path.dup
			@final_paths << end_path
		end
end