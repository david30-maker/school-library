class Book
  attr_accessor :title, :author
  attr_reader :rentals, :id

  def initialize(id, title, author)
    @id = id
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.book = self
  end
end
