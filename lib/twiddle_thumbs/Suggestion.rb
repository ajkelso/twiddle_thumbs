class Suggestion

    attr_accessor :activity, :price, :type, :participants, :link, :key, :accessibility

    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        if self.price == 0
            self.price = "Free!"
        elsif self.price.between?(0.01, 0.19)
            self.price = "Cheap"
        elsif self.price.between?(0.2, 0.5)
            self.price = "Costs a little $$"
        elsif self.price > 0.51
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
        puts rainbow(self.activity)
        print "Type: ".blue + "#{self.type.capitalize.magenta}"
        if self.type == "social"
            print " * Please consider wearing a mask and be sure to follow social distance guidelines *".red
        end
        puts "\nPrice: ".blue + "#{self.price.magenta}"
        puts "Participants: ".blue + "#{self.participants.to_s.magenta}"
    end

    def rainbow(string)
        words = string.split(" ")
        colors = [:red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan]
        x = 0
        array_of_words_rainbow = []
        while x < words.length
            array_of_words_rainbow << words[x].colorize(colors[x])
            x += 1
        end
        puts "#{array_of_words_rainbow.join(" ")}!"
    end
    

end
