require './person.rb'

class Teacher < Person
    def initialize(age, specialization, parent_permission = true, name = "Unknown")
        super(age, parent_permission, name)
        @specialization = specialization
    end

    def can_use_service?
        true
    end
end