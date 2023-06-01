require './nameable'

class Person < Nameable
  attr_reader :name
  attr_accessor :rentals

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
