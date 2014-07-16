require 'ostruct'

class AllPaths

	class << self

		def create(flights, departure_city, arrival_city)
			all_paths = []
			flights.each_with_index do |flight,index|
				if flight.from == departure_city
					@new_path = OpenStruct.new(:from => departure_city, :to => flight.to, :dep => flight.dep, :arr => flight.arr, :price => flight.price)
					if flight.to == arrival_city
						all_paths << @new_path
					else 
						final_path = get_path(flights,@new_path)
						all_paths << final_path
					end
				end
			end
			all_paths
		end

		def get_path(flights, flight_path)
			flights.each do |flight|
				if flight_path.to == flight.from
					return new_path = OpenStruct.new(:from => flight_path.from, :to => flight.to, :dep => flight_path.dep, :arr => flight.arr, :price => flight_path.price + flight.price)
				end
			end
		end
	end
end