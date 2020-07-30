class TwiddleThumbs::CLI
    def call
        welcome
        bored
        suggestion_list
        get_first_choice
        category_list
        goodbye
    end

    def welcome
        puts "Welcome to Twiddle Thumbs!!".blue
    end

    def bored
        puts "Are you bored?".light_blue
        print "y/n:".blue
        answer = gets.chomp
        if answer == "y"
            puts "You're in Luck!!"
            puts "Let's help find you something interesting to do..."
        elsif answer == "n"
            puts "Good for you!!!"
            goodbye
            exit
        else
            puts "Invalid entry".red
            bored
        end
    end

    def suggestion_list
        puts "How would you like to search for an activity?"
        @parameters = ["Price", "Type", "Number of Participants", "Random"]
        @parameters.each_with_index {|parameter, index| puts "#{index + 1}. #{parameter}"}
    end

    def get_first_choice
        @first_choice = gets.chomp.to_i
    end

    def category_list
        if @first_choice = 1
            Type.new("recreational")
        end
    end


    def goodbye
        puts "Stay busy...Thanks for stopping by!  Goodbye!".green
    end


end
