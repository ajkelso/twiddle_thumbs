class Type

    attr_accessor :title, :url
    
    def initialize
        @types = ["Recreational", "Education", "Social", "Music", "Cooking", "Relaxation", "Busywork"]
        @title = nil
    end

    def choose_type
        @types.each_with_index {|type, index| puts "#{index + 1}. #{type}"}
        print "Which type of activity would you like?"
        input = gets.chomp.to_i
        if input.between?(1, 7)
            self.title = @types[input - 1]
        else
            puts "Please enter a vaild number".red
        end
        puts self.title
    end

    def create_url
        @url = "http://www.boredapi.com/api/activity?type=#{self.title.downcase}"
    end



    
end
