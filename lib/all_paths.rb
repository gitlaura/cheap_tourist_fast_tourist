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
					reset_arrivals(flight_from_dep_city)
					reset_arrival_cities(flight_from_dep_city)
					update_current_path(flight_from_dep_city.to, from_city_groups)
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
			OpenStruct.new(:from => @departure_city, :to => nil, :dep => flight.dep, :arr => nil, :price => nil)
		end

		def reset_price(flight)
			@prices = []
			@prices << flight.price
		end

		def reset_arrivals(flight)
			@arrival_times = []
			@arrival_times << flight.arr
		end

		def reset_arrival_cities(flight)
			@arrival_cities = []
			@arrival_cities << flight.to
		end

		def update_current_path(current_from_city, from_city_groups, loop = false)
			new_from_city = current_from_city.to_sym
			from_city_groups[new_from_city].each do |possible_flight|
				if loop == false 
					reset_to_price_from_city if @prices.size > 1
					reset_arrivals_from_city if @arrival_times.size > 1
					reset_arrival_cities_from_city if @arrival_cities.size > 1
				end
				if valid_next_flight?(possible_flight)
					#update_path(possible_flight)
					update_price(possible_flight)
					update_arrivals(possible_flight)
					update_arrival_cities(possible_flight)
					if possible_flight.to == @arrival_city
						add_prices_to_path
						add_arrivals_to_path(possible_flight)
						add_arrival_cities_to_path(possible_flight)
						reset_to_price_from_city
						reset_arrivals_from_city
						reset_arrival_cities_from_city
						add_current_path_to_final_paths(possible_flight)
						next
					end
					update_current_path(@arrival_cities.last, from_city_groups, true)
				end
			end
		end	

		def valid_next_flight?(possible_flight)
			@arrival_times.last < possible_flight.dep && possible_flight.to > possible_flight.from
		end

		def update_path(possible_flight)
			@current_path.to = possible_flight.to if possible_flight.to != @arrival_city
		end

		def update_price(possible_flight)
			@prices << possible_flight.price		
		end

		def update_arrivals(possible_flight)
			@arrival_times << possible_flight.arr		
		end

		def update_arrival_cities(possible_flight)
			@arrival_cities << possible_flight.to		
		end

		def add_prices_to_path
			@current_path.price = @prices.reduce(:+)
		end

		def add_arrivals_to_path(possible_flight)
			@current_path.arr = @arrival_times.last
		end

		def add_arrival_cities_to_path(possible_flight)
			@current_path.to = @arrival_cities.last
		end

		def reset_to_price_from_city
			@prices.pop
		end

		def reset_arrivals_from_city
			@arrival_times.pop
		end

		def reset_arrival_cities_from_city
			@arrival_cities.pop
		end

		def add_current_path_to_final_paths(possible_flight)
			end_path = @current_path.dup
			@final_paths << end_path
		end
end