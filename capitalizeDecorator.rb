require './decorator'

class CapitalizeDecorator < Decorator
  def correct_name
    # super.capitalize
    @nameable.correct_name.capitalize
  end
end
