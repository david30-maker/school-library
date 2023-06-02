require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    puts 'List of all books:'
    @books.each do |book|
      puts "Id: #{book.id}, Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people:'
    @people.each_with_index do |person, index|
      puts "Id: #{index + 1}, Name: #{person.name}, Type: #{person.class.name}"
    end
  end

  def create_person(id, name, age, type)
    if type == 'student'
      puts 'Enter the classroom:'
      classroom = gets.chomp
      student = Student.new(id, name, age, classroom)
      add_person(student)
    elsif type == 'teacher'
      puts 'Enter the specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(id, age, specialization, name: name)
      add_person(teacher)
    else
      puts 'Invalid person type.'
    end
  end

  def add_person(person)
    @people << person
  end

  def create_book(id, title, author)
    book = Book.new(id, title, author)
    @books << book
  end

  def create_rental(id, book_id, person_id, date)
    puts '********************************'
    puts book_id
    puts person_id
    @books.each { |b| puts b.id, b.title }
    @people.each { |p| puts p.id, p.name }

    book = @books.find { |b| b.id == book_id }
    person = @people.find { |p| p.id == person_id }

    if book && person
      rental = Rental.new(id, book, person, date)
      @rentals << rental
      puts 'Rental created successfully.'

    else
      puts 'Invalid book ID or person ID.'
    end
  end

  def list_rentals_for_person(person_id)
    person = @people.find { |p| p.id == person_id }

    if person
      rentals_for_user = @rentals.select { |rental| rental.person == person }
      if rentals_for_user.empty?
        puts "No rentals found for the person with ID #{person_id}."
      else
        puts "Rentals for the person with ID #{person_id}:"
        rentals_for_user.each do |rental|
          puts "Rental ID: #{rental.id}"
          puts "Book: #{rental.book.title} by #{rental.book.author}"
          puts "Rental Date: #{rental.date}"
          puts '------'
        end
      end
    else
      puts 'Invalid person ID.'
    end
  end
end

# app = App.new

# # List all books
# app.list_all_books

# # List all people
# app.list_all_people

# # Create a person
# app.create_person('John Doe', 'student')

# # Create a book
# app.create_book('Book Title', 'Author')

# # Create a rental
# app.create_rental(book_id, person_id, '2023-05-29')

# # List rentals for a person
# app.list_rentals_for_person(person_id)

# app = App.new
# app.create_person(1, 'John Doe', 12, 'student')
# app.create_book(1, 'Book Title', 'Author')
# app.create_rental(1, 1, 1, '2023-05-29')

# app.books.each { |b| puts "Book #{b.id}"}
# app.people.each { |p| puts "People #{p.id}"}
