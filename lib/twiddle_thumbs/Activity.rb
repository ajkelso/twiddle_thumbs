class Activity

    attr_accessor :activity, :price, :type, :participants, :link, :key, :accessibility

    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        if self.price == 0
            self.price = "Free!"
        elsif self.price.between?(0.01, 0.19)
            self.price = "Cheap"
        elsif self.price.between?(0.2, 0.6)
            self.price = "Costs a little $$"
        elsif self.price > 0.6
            self.price = "EXPENSIVE"
        end
        @@all << self
    end

    def self.all
        @@all
    end
    
    def pretty_print
        system 'clear'
        puts "You should...".blue
        puts "\n"
        puts "#{self.activity}!".light_cyan.underline
        puts "\n"
        puts "Type: ".blue + "#{self.type.capitalize.magenta}"
        puts "Price: ".blue + "#{self.price.magenta}"
        puts "Participants: ".blue + "#{self.participants.to_s.magenta}"
    end
    

end
