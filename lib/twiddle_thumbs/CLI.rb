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
        puts rainbow("!!!WELCOME TO TWIDDLE THUMBS!!!") 
        puts "\n -If you're bored, we're here to help- \n\n".magenta
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
        parameter_list
        get_parameter_choice
        url_from_category_list
        get_activity
        another_activity
    end

    def parameter_list
        puts "OK...Let's help find you something interesting to do!\nHow would you like to search for an activity?\n".light_blue
        @parameter_list = ["Price", "Type", "Participants", "Random"]
        @parameter_list.each_with_index {|parameter, index| puts "#{index + 1}. ".blue + "#{parameter}".light_cyan}
        puts "\n \n"
        print "Which selection would you like: ".magenta
    end

    def get_parameter_choice
        @input = gets.chomp.to_i
        if @input.between?(1, @parameter_list.length)
            @choice = @parameter_list[@input - 1]
        else
            puts "Please enter a valid number.".red
            get_parameter_choice
        end
    end

    def url_from_category_list
        if @choice == "Random"
            @url = "http://www.boredapi.com/api/activity/"
        else
            if @choice == "Type"
                @category_list = ["Recreational", "Education", "Social", "Music", "Cooking", "Relaxation", "Busywork", "Charity"]
                category_choice
                create_type_url
            elsif @choice == "Price"
                @category_list = ["Free", "Cheap", "Costs a little $$", "Expensive"]
                category_choice
                translate_price
                create_url
            elsif @choice == "Participants"
                @category_list = ["1 Person", "2 People", "3 People", "4 or more"]
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
        @category_list.each_with_index {|selection, index| puts "#{index + 1}. ".light_blue + "#{selection}".light_magenta}
        get_category_choice
    end

    def get_category_choice
        print "\n"
        print "Which selection would you like?: ".light_blue
        input = gets.chomp.to_i 
        if input.between?(1, @category_list.length)
                @category_selection = @category_list[input - 1]
        else
            puts "Please enter a vaild number".red
            get_category_choice
        end
        puts @category_selection
    end

    def create_type_url
        @url = "http://www.boredapi.com/api/activity?" + "type=#{@category_selection.downcase}"
    end

    def translate_price
        if @category_selection == "Free"
            @category_selection = "price=0.0"
        elsif @category_selection == "Cheap"
            @category_selection = "minprice=0.01&maxprice=0.19"
        elsif @category_selection =="Costs a little $$"
            @category_selection = "minprice=0.2&maxprice=0.5"
        elsif @category_selection == "Expensive"
            @category_selection = "minprice=0.51&maxprice=1"
        end
    end

    def translate_participants
        if @category_selection == @category_list[0]
            @category_selection = "participants=1"
        elsif @category_selection == @category_list[1]
            @category_selection = "participants=2"
        elsif @category_selection == @category_list[2]
            @category_selection = "participants=3"
        elsif @category_selection == @category_list[3]
            @category_selection = "minparticipants=4"
        end
    end

    def create_url
        @url = "http://www.boredapi.com/api/activity?#{@category_selection}"
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
        activities = Activity.all.map {|activity| activity.activity}.uniq
        activities.each_with_index do |activity, index| 
            print "#{index + 1}. " 
            print "#{rainbow(activity)}"
        end
    end

    def goodbye
        puts "\n \n"
        puts "Stay busy & Thanks for stopping by!  Goodbye! \n\n".light_cyan
    end

    def rainbow(string)
        characters = string.split(" ")
        colors = [:red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan, :red, :green, :yellow, :blue, :light_magenta, :light_cyan]
        x = 0
        color_array = []
        while x < characters.length
            color_array << characters[x].colorize(colors[x])
            x += 1
        end
        puts color_array.join(" ")
    end



end
