class Price

    include ChooseAndCreate

    def initialize
        @list = ["Free", "Cheap", "Costs a little $$", "Expensive"]
    end

    def choose
        super
        translate_price
    end

    def translate_price
        if self.title == "Free"
            self.title = "selection=0.0"
        elsif self.title == "Cheap"
            self.title = "minprice=0.01&maxprice=0.19"
        elsif self.title =="Costs a little $$"
            self.title = "minprice=0.2&maxprice=0.6"
        elsif self.title == "Expensive"
            self.title = "minprice=0.61&maxprice=1"
        end
    end
        
end
