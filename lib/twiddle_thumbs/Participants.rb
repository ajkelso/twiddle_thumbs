class Participants

    include ChooseAndCreate

    def initialize
        @list = ["1 Person", "2 People", "3 People", "4 or more"]
    end

    def choose
        super
        translate
    end

    def translate
        if self.title == @list[0]
            self.title = "participants=1"
        elsif self.title == @list[1]
            self.title = "participants=2"
        elsif self.title == @list[2]
            self.title = "participants=3"
        elsif self.title == @list[3]
            self.title = "minparticipants=4"
        end
    end
end