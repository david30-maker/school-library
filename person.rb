class Person
     attr_reader :id, :name, :age

    def initialize(age, parent_permission = true, name = 'Unknown')
        @id = generated_id
        @name = name
        @age = age
        @parent_permission = parent_permission
    end

    def name=(name)
        @name = name
    end

    def age=(age)
        @age = age
    end

    def can_use_service?
        of_age? || @parent_permission
    end

    private

    def of_age?
        @age >= 18
    end

    def generated_id
        rand(1000..9999)
    end

end
