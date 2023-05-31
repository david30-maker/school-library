require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, parent_permission: true, name: 'Unknown')
    super(age, parent_permission, name)
    @classroom = classroom

    return unless classroom

    classroom.add_student(self)
  end
end
