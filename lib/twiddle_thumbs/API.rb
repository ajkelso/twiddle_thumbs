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
            hash["price"] = "Costs a little $$"
        elsif hash["price"] > 0.6
            hash["price"] = "EXPENSIVE"
        end
        values = hash.values
        system 'clear'
        puts "You should...".blue
        puts "\n"
        puts "#{values[0]}!".light_cyan.underline
        puts "\n"
        puts "Type: ".blue + "#{values[1].capitalize.magenta}"
        puts "Price: ".blue + "#{values[3].magenta}"
        puts "Participants: ".blue + "#{values[2].to_s.magenta}"
    end

    
    





end
