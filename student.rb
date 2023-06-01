require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(name, age, classroom, parent_permission: true)
    super(name, age, parent_permission)
    @classroom = classroom

    return unless classroom

    classroom.add_student(self)
  end
end
