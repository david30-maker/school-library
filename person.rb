require './nameable'

class Person < Nameable
  attr_reader :name

  def initialize(age, parent_permission: true, name: 'Unknown')
    super(name)
    @age = age
    @parent_permission = parent_permission
  end

  def correct_name
    @name
  end
end
