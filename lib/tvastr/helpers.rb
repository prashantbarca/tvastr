module Tvastr
    @@output_file = ""

    def self.get_file
        @@output_file
    end

    def self.put_file name
        @@output_file = name
    end

	def many 
		"many"
	end
	def many1 
		"many1"
	end
	def optional
		"optional"
	end
end
