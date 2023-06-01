require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_all_books
    puts 'List of all books:'
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people:'
    @people.each do |person|
      puts "#{person.name} (#{person.class})"
    end
  end

  def create_person(app)
    puts 'Enter the person name:'
    name = gets.chomp

    puts 'Enter the person age:'
    age = gets.chomp.to_i

    puts 'Enter the person type (student/teacher):'
    type = gets.chomp.downcase

    if type == 'student'
      puts 'Enter the classroom:'
      classroom = gets.chomp
      app.add_student(Student.new(name, age, classroom))
    elsif type == 'teacher'
      puts 'Enter the specialization:'
      specialization = gets.chomp
      app.add_teacher(Teacher.new(name, age, specialization))
    else
      puts 'Invalid person type.'
    end
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts "Created book: #{book.title} by #{book.author}"
  end

  def create_rental(book_id, person_id, date)
    selected_book = @books.find { |book| book.id == book_id }
    @people.find { |person| person.id == person_id }

    if selected_book && person
      rental = Rental.new(selected_book, person, date)
      @rentals << rental
      puts "Created rental: #{rental.book.title} rented by #{rental.person.name}"
    else
      puts 'Book or person not found.'
    end
  end

  def list_rentals_for_person(person_id)
    selected_person = @people.find { |p| p.id == person_id }

    if selected_person
      rentals = @rentals.select { |rental| rental.person == selected_person }
      if rentals.empty?
        puts "No rentals found for person with ID #{person_id}."
      else
        puts "Rentals for person with ID #{person_id}:"
        rentals.each do |rental|
          puts "Book: #{rental.book.title}, Rental Date: #{rental.date}"
        end
      end
    else
      puts 'Person not found.'
    end
  end
end

# # Usage example:
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
