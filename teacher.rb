require './person'

class Teacher < Person
  attr_reader :id, :age, :specialization, :name

  def initialize(id, age, specialization, name: 'Unknown')
    super(id, name, age)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
