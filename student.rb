require './person'
require './class_room'

class Student < Person
  attr_accessor :classroom

  def initialize(id, name, _age, classroom_name)
    super(id, name)
    @classroom = ClassRoom.new(classroom_name)

    return unless classroom

    classroom.add_student(self)
  end
end
