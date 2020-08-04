class TwiddleThumbs::CLI
    def call
        system 'clear'
        welcome
        bored
        activity_process
        list_all_activities
        goodbye
    end

    def welcome
        puts "!!!WELCOME TO TWIDDLE THUMBS!!!".blue.underline + "\n \n -If you're bored, we're here to help- \n\n".magenta
    end

    def bored
        print "Are you bored? y/n:".light_cyan
        answer = gets.chomp.downcase
        if answer.start_with?("y")
            system 'clear'
        elsif answer.start_with?("n")
            goodbye
            exit
        else
            puts "Invalid entry".red
            bored
        end
    end

    def activity_process
        suggestion_list
        get_choice
        category_list
        get_activity
        another_activity
    end

    def suggestion_list
        puts "OK...Let's help find you something interesting to do!\nHow would you like to search for an activity?\n".light_blue
        @parameter_list = ["Price", "Type", "Participants", "Random"]
        @parameter_list.each_with_index {|parameter, index| puts "#{index + 1}. ".blue + "#{parameter}".light_cyan}
        puts "\n \n"
        print "Which selection would you like: ".magenta
    end

    def get_choice
        @input = gets.chomp.to_i
        if @input.between?(1, @parameter_list.length)
            @choice = @parameter_list[@input - 1]
        else
            puts "Please enter a valid number.".red
            get_choice
        end
    end

    def category_list
        if @choice == "Random"
            @url = "http://www.boredapi.com/api/activity/"
        else
            if @choice == "Type"
                @parameter = Type.new
            elsif @choice == "Price"
                @parameter = Price.new
            elsif @choice == "Participants"
                @parameter = Participants.new
            end
            @parameter.choose
            @parameter.get_choice
            @url = @parameter.create_url
        end
    end

    def get_activity
        api = Api.new(@url)
        activity = Activity.new(api.parse_json)
        activity.pretty_print
    end

    def another_activity
        puts "\n \n"
        print "Would you like to find another activity? y/n: ".cyan
        answer = gets.chomp
        if answer == "y"
            system 'clear'
            activity_process
        elsif answer != "n"
            puts "Invalid Entry".red
            another_activity
        end
    end

    def list_all_activities
        system 'clear'
        puts "Here's your new to-do list!\n".light_cyan
        Activity.all.each_with_index {|activity, index| puts "#{index + 1}. #{activity.activity.yellow}"}
       
    end

    def goodbye
        puts "\n \n"
        puts "Stay busy & Thanks for stopping by!  Goodbye!".light_cyan
    end


end
