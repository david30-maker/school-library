require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_books
    puts 'List of books:'
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_people
    puts 'List of people:'
    @people.each do |person|
      puts "#{person.name} (#{person.class})"
    end
  end

  def create_person(name, age, parent_permission, specialization = nil)
    person = if specialization.nil?
               Student.new(name, age, parent_permission)
             else
               Teacher.new(name, age, parent_permission, specialization)
             end
    @people << person
    person
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def list_rentals_for_person(person_id)
    person_rentals = @rentals.select { |rental| rental.person.id == person_id }

    if person_rentals.empty?
      puts "No rentals found for the person with ID #{person_id}."
    else
      person = @people.find { |p| p.id == person_id }
      puts "Rentals for #{person.name}:"
      person_rentals.each do |rental|
        book = @books.find { |b| b.id == rental.book_id }
        puts "#{book.title} (Rental Date: #{rental.date})"
      end
    end
  end

  rental = Rental.new(book, person, date)
  person.add_rental(rental)
  book.add_rental(rental)
  @rentals << rental

  rental
end

def list_rentals(person_id)
  person = @people.find { |p| p.id == person_id }

  if person
    rentals = @rentals.select { |rental| rental.person == person }

    if rentals.empty?
      puts "No rentals found for person with ID #{person_id}."
    else
      puts "Rentals for person with ID #{person_id}:"
      rentals.each do |rental|
        puts "Book ID: #{rental.book.id}, Title: #{rental.book.title}, Date: #{rental.date}"
      end
    end
  else
    puts "Person with ID #{person_id} not found."
  end
end

app = App.new

book1 = app.create_book('Book 1', 'Author 1')
book2 = app.create_book('Book 2', 'Author 2')
book3 = app.create_book('Book 3', 'Author 3')

app.list_books

teacher = app.create_person('John Doe', 35, true, 'Mathematics')

student = app.create_person('Jane Smith', 17, true)

app.list_people

app.create_rental(teacher.id, book1.id, '2023-05-30')
app.create_rental(student.id, book2.id, '2023-06-01')
app.create_rental(student.id, book3.id, '2023-06-03')

app.list_rentals(student.id)
