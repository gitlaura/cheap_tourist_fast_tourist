class FlightFormatter
	class << self
		def get_print_format(flights)
				@line_to_print = ""
				flights.each do |flight|
					departure_time = format_time(flight.dep)
					arrival_time = format_time(flight.arr)
					price = format_price(flight.price)
					@line_to_print << "#{departure_time} #{arrival_time} #{price}\n"
				end
				@line_to_print << "\n"
			end

			def format_time(time)
				"#{'%02d' % (time / 60)}:#{'%02d' % (time % 60)}"
			end

			def format_price(price)
				"#{"%.2f" % price}"
			end
		end
end