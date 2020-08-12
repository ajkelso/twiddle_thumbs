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
        puts "WELCOME TO:".magenta
        puts "                                                            __ __ __ ".red
        puts " _____       _   _   _ _        _____ _             _      |  |  |  |".red
        puts "|_   _|_ _ _|_|_| |_| | |___   |_   _| |_ _ _ _____| |_ ___|  |  |  |".yellow
        puts "  | | | | | | | . | . | | -_|    | | |   | | |     | . |_ -|__|__|__|".green
        puts "  |_| |_____|_|___|___|_|___|    |_| |_|_|___|_|_|_|___|___|__|__|__|".blue   
                                                                                                 
        puts "\n -If you're bored, we're here to help- \n\n".magenta
    end

    def bored
        print "Are you bored? y/n:".light_cyan
        bored_answer = gets.chomp.downcase
        if bored_answer.start_with?("y")
            system 'clear'
        elsif bored_answer.start_with?("n") || bored_answer == "exit"
            goodbye
            exit
        else
            puts "Invalid entry".red
            bored
        end
    end

    def activity_process
        parameter_list
        get_parameter_choice
        url_from_category_list
        get_activity
        another_activity
    end

    def parameter_list 
        puts rainbow("OK... Let's help find you something interesting to do!")
        puts "\nHow would you like to search for an activity?\n".light_blue
        @parameter_list = ["Price", "Type", "Participants", "Random"]
        @parameter_list.each_with_index {|parameter, index| puts "#{index + 1}. ".blue + "#{parameter}".light_cyan}
        puts "\n \n"
    end

    def get_parameter_choice
        print "Which selection would you like: ".magenta
        @input = gets.chomp.to_i
        if @input.between?(1, @parameter_list.length)
            @chosen_category = @parameter_list[@input - 1]
        else
            puts "Please enter a valid number.".red
            get_parameter_choice
        end
    end

    def url_from_category_list
        if @chosen_category == @parameter_list[3]
            @url = "http://www.boredapi.com/api/activity/"
        else
            if @chosen_category == @parameter_list[1]
                @sub_categories = ["Recreational", "Education", "Social", "Music", "Cooking", "Relaxation", "Busywork", "Charity"]
                category_choice
                create_type_url
            elsif @chosen_category == @parameter_list[0]
                @sub_categories = ["Free", "Cheap", "Costs a little $$", "Expensive"]
                category_choice
                translate_price
                create_url
            elsif @chosen_category == @parameter_list[2]
                @sub_categories = ["1 Person", "2 People", "3 People", "4 or more"]
                category_choice
                translate_participants
                create_url
            end
        end
    end

    def category_choice
        system "clear"
        puts "Choose from the list below:".blue
        puts "\n"
        @sub_categories.each_with_index {|sub_category, index| puts "#{index + 1}. ".light_blue + "#{sub_category}".light_magenta}
        puts "\n"
        get_sub_category_choice
    end

    def get_sub_category_choice
        print "Which selection would you like?: ".light_blue
        input = gets.chomp.to_i 
        if input.between?(1, @sub_categories.length)
                @sub_category_choice = @sub_categories[input - 1]
        else
            puts "Please enter a vaild number".red
            get_sub_category_choice
        end
        puts @sub_category_choice
    end

    def create_type_url
        @url = "http://www.boredapi.com/api/activity?" + "type=#{@sub_category_choice.downcase}"
    end

    def translate_price
        if @sub_category_choice == "Free"
            @sub_category_choice = "price=0.0"
        elsif @sub_category_choice == "Cheap"
            @sub_category_choice = "minprice=0.01&maxprice=0.19"
        elsif @sub_category_choice =="Costs a little $$"
            @sub_category_choice = "minprice=0.2&maxprice=0.5"
        elsif @sub_category_choice == "Expensive"
            @sub_category_choice = "minprice=0.51&maxprice=1"
        end
    end

    def translate_participants
        if @sub_category_choice == @sub_categories[0]
            @sub_category_choice = "participants=1"
        elsif @sub_category_choice == @sub_categories[1]
            @sub_category_choice = "participants=2"
        elsif @sub_category_choice == @sub_categories[2]
            @sub_category_choice = "participants=3"
        elsif @sub_category_choice == @sub_categories[3]
            @sub_category_choice = "minparticipants=4"
        end
    end

    def create_url
        @url = "http://www.boredapi.com/api/activity?#{@sub_category_choice}"
    end

    def get_activity
        api = Api.new(@url)
        suggestion = Suggestion.new(api.parse_json)
        suggestion.pretty_print
        puts "\n \n"
    end

    def another_activity
        print "Would you like to find another activity? y/n: ".cyan
        answer = gets.chomp.downcase
        if answer.start_with?("y")
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
        activities = Suggestion.all.map {|suggestion| suggestion.activity}.uniq
        activities.each_with_index do |activity, index| 
            puts "#{index + 1}. #{rainbow(activity)}!"
        end
    end

    def goodbye
        puts "\n \n"
        puts "Stay busy & Thanks for visiting".light_cyan
        puts "                                                            __ __ __ ".red
        puts " _____       _   _   _ _        _____ _             _      |  |  |  |".red
        puts "|_   _|_ _ _|_|_| |_| | |___   |_   _| |_ _ _ _____| |_ ___|  |  |  |".yellow
        puts "  | | | | | | | . | . | | -_|    | | |   | | |     | . |_ -|__|__|__|".green
        puts "  |_| |_____|_|___|___|_|___|    |_| |_|_|___|_|_|_|___|___|__|__|__|\n\n".blue   
    end

    def rainbow(string)
        words = string.split(" ")
        colors = [:red, :green, :yellow, :blue, :light_magenta, :light_cyan]
        words.zip(colors.cycle).map {|word, color| word.colorize(color)}.join(" ")
    end
end
