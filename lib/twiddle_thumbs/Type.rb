class Type
    def initialize(type)
        API.new("?type=#{type}")
    end
end
