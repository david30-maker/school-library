require './nameable'

class Person < Nameable
  attr_reader :name, rentals

  # def initialize(age, parent_permission: true, name: 'Unknown')
  #   super(name)
  #   @age = age
  #   @parent_permission = parent_permission
  # end

  # def correct_name
  #   @name
  # end

  def initialize(name)
    super()
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end
end
