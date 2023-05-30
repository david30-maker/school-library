require './decorator'

class TrimmerDecorator < Decorator
    def correct_name
        # @nameable.correct_name.strip
    #     super.strip
    trimmed_name = @nameable.correct_name[0, 10]
    trimmed_name.length < @nameable.correct_name.length ? "#{trimmed_name}..." : trimmed_name
    end
end