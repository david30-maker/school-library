class Rental
  attr_accessor :id, :book, :person, :date

  def initialize(id, book, person, date)
    @id = id
    @book = book
    @person = person
    @date = date
  end
end
