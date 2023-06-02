require './person'

class Teacher < Person
  def initialize(id, _age, specialization, name: 'Unknown')
    super(id, name)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
