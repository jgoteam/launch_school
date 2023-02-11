class Furniture
	def initialize
		@color = "black"
	end

	def break_furniture
		puts "uh oh, looks like its broken."
	end
end

class Chair < Furniture
	def initialize
		@height = 5
		super
	end
end

class OfficeChair < Chair
	def super_super
		puts "I can see the #{@color}."
	end

	def super
		puts "I can see the #{@height}"
	end
end

zoomer = OfficeChair.new
zoomer.super_super
zoomer.super
zoomer.break_furniture