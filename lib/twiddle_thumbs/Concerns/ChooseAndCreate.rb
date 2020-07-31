module ChooseAndCreate
    
    attr_accessor :title, :url
    
    def choose
        system "clear"
        puts "Choose from the list below:".blue
        puts "\n"
        @list.each_with_index {|selection, index| puts "#{index + 1}. ".light_blue + "#{selection}".light_magenta}
        print "\n \n"
        print "Which selection would you like?: ".light_blue
        input = gets.chomp.to_i
        if input.between?(1, @list.length)
            self.title = @list[input - 1]
        else
            puts "Please enter a vaild number".red
        end
        puts self.title
    end

    def create_url
        @url = "http://www.boredapi.com/api/activity?#{self.title}"
    end
    
end
