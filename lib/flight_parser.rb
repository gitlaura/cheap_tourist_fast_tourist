require 'ostruct'

class FlightParser
	class << self
		def parse(txt_file)
			all_cases = []
			flights_created = 0

			file = File.open(txt_file).read
			file.each_line.with_index do |line, index|
				if empty_line?(line, index)
					next
				elsif number_of_cases?(line)
					@number_of_flights = line.strip.to_i
					@new_case = []
					flights_created = 0
				else
					from, to, dep, arr, price = line.strip.split(" ")
					@new_case << create_flight(from, to, dep, arr, price)
					flights_created += 1
					all_cases << @new_case if flights_created == @number_of_flights
				end
			end
			all_cases
		end

		def create_flight(from, to, dep, arr, price)
			OpenStruct.new(
				:from => from,
				:to => to,
				:dep => to_number(dep),
				:arr => to_number(arr),
				:price => price.to_f
				)
		end

		def to_number(time)
			hour, minutes = time.split(":")
			hour.to_i * 60 + minutes.to_i
		end

		def empty_line?(line, index)
			index < 2 || line == "\n"
		end

		def number_of_cases?(line)
			line.strip.to_i > 0
		end
	end
end