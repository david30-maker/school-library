require './nameable'

class Decorator < Nameable
    def initialize(nameable)
        @nameable = nameable

    def correct_name
        @nameable.correct_name
    end
end