class Rental
  attr_accessor :book, :person, :date

  def initialize(book, person, date)
    @book = book
    @person = person
    @date = date
  end
end
