require 'net/http'
require 'open-uri'
require 'json'

class Api
    def initialize(url)
        @url = url
    end

    def get_response_body
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body 
    end

    def parse_json
        JSON.parse(get_response_body)
    end

    def pretty_print
        hash = parse_json
        if hash["price"] == 0
            hash["price"] = "Free!"
        elsif hash["price"].between?(0.01, 0.19)
            hash["price"] = "Cheap"
        elsif hash["price"].between?(0.2, 0.6)
            hash["price"] = "Somewhat Expensive"
        elsif hash["price"] > 0.6
            hash["price"] = "EXPENSIVE"
        end
        values = hash.values
        puts "Activity: #{values[0].yellow}"
        puts "Type: #{values[1].capitalize.cyan}"
        puts "Price: #{values[3].green}"
        puts "Participants: #{values[2].to_s.blue}"
    end

    
    





end
