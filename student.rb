require './person'
require './class_room'

class Student < Person
  attr_accessor :classroom

  def initialize(id, name, age, classroom_name)
    super(id, name, age)
    @classroom = ClassRoom.new(classroom_name)

    return unless classroom

    classroom.add_student(self)
  end
end
