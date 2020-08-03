class Type
    include ChooseAndCreate

    attr_accessor :title
    
    def initialize
        @list = ["Recreational", "Education", "Social", "Music", "Cooking", "Relaxation", "Busywork", "DIY", "Charity"]
    end
    
    def create_url
        title = "type=#{self.title.downcase}"
        self.title = title
        super
    end
end
