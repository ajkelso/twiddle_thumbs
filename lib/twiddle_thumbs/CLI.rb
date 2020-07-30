class TwiddleThumbs::CLI
    def call
        system 'clear'
        welcome
        bored
        activity_process
        goodbye
    end

    def welcome
        puts "Welcome to Twiddle Thumbs!!".blue
    end

    def bored
        puts "Are you bored?".light_blue
        print "y/n:".blue
        answer = gets.chomp
        system 'clear'
        if answer == "y"
            puts "You're in Luck!!"
            puts "Let's help find you something interesting to do..."
            puts "\n"
        elsif answer == "n"
            goodbye
            exit
        else
            puts "Invalid entry".red
            bored
        end
    end

    def activity_process
        suggestion_list
        get_first_choice
        category_list
        get_activity
        still_bored
    end

    def suggestion_list
        @parameter_list = ["Price", "Type", "Participants", "Random"]
        @parameter_list.each_with_index {|parameter, index| puts "#{index + 1}. #{parameter}"}
        print "Please choose how you would like to search for an activity using the list number:"
    end

    def get_first_choice
        @input = gets.chomp.to_i
        if @input.between?(1, 4)
            @choice = @parameter_list[@input - 1]
        else
            puts "Please enter a valid number.".red
            get_first_choice
        end
    end

    def category_list
        if @choice == "Type"
            @parameter = Type.new
            @parameter.choose_type
            @url = @parameter.create_url
            binding.pry
        elsif @choice == "Price"
            @parameter = Price.new
            @parameter.choose_price
            @url = @parameter.create_url
        end

        
        
        
        # if @choice == "Price"
        #     @price = ["Free", "Cheap", "Somewhat Expensive", "Expensive"]
        #     @price.each_with_index {|cost, index| puts "#{index + 1}. #{cost}"}
    end

    def get_activity
        Api.new(@url).pretty_print
    end

    def still_bored
        print "Are you still bored? y/n: "
        answer = gets.chomp
        if answer == "y"
            system 'clear'
            activity_process
        end
    end

    def goodbye
        puts "\n \n"
        puts "Great!!  Stay busy & Thanks for stopping by!  Goodbye!".green
    end


end
