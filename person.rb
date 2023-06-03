require './nameable'

class Person < Nameable
  attr_reader :id, :name
  attr_accessor :rentals

  def initialize(id, name, _age)
    super()
    @id = id
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end
end
