class Price

    attr_accessor :title, :url

    def initialize
        @prices = ["Free", "Cheap", "Costs a little $$", "Expensive"]
        @title = nil
    end

    def choose_price
        system "clear"
        @prices.each_with_index {|price, index| puts "#{index + 1}. #{price}"}
        print "Which price would you like? "
        input = gets.chomp.to_i
        if input.between?(1, 7)
            self.title = @prices[input - 1]
        else
            puts "Please enter a vaild number".red
        end
        puts self.title
        translate_price
    end

    def translate_price
        if self.title == "Free"
            self.title = "price=0.0"
        elsif self.title == "Cheap"
            self.title = "minprice=0.01&maxprice=0.19"
        elsif self.title =="Costs a little $$"
            self.title = "minprice=0.2&maxprice=0.6"
        elsif self.title == "Expensive"
            self.title = "minprice=0.61&maxprice=1"
        end
    end
        



    def create_url
        @url = "http://www.boredapi.com/api/activity?#{self.title}"
    end
        
end
