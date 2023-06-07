require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
    load_data
  end

  def list_all_books
    puts 'List of all books:'
    @books.each_with_index do |book, index|
      puts "#{index}) - Id: #{book.id}, Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people:'
    @people.each_with_index do |person, index|
      puts "#{index}) - Id: #{person.id}, Name: #{person.name}, Type: #{person.class.name}"
    end
  end

  def create_person(name, age, type)
    id = @people.size + 1
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

  def create_book(title, author)
    id = @books.size + 1
    book = Book.new(id, title, author)
    @books << book
  end

  def create_rental(book_index, person_index, date)
    id = @rentals.size + 1
    book = @books[book_index]
    person = @people[person_index]

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

  preserve data
  def save_books
    CSV.open('data/books.csv', 'wb') do |csv|
      @books.each do |book|
        csv << [book.id, book.title, book.author] # array of arrays
      end
    end
  end

  def save_people
    CSV.open('data/people.csv', 'wb') do |csv|
      @people.each do |person|
        csv << [person.id, person.name, person.age, person.class.name, if person.instance_of?(Student)
                                                                         person.classroom
                                                                       else
                                                                         person.specialization
                                                                       end]
        array of arrays
      end
    end
  end

  def save_rentals
    CSV.open('data/rentals.csv', 'wb') do |csv|
      @rentals.each do |rental|
        csv << [rental.id, rental.book.id, rental.person.id, rental.date]
        array of arrays
      end
    end
  end

  # let's preserve our data in json format here!

  def save_data
    save_to_json('book.json', @book)
    save_to_json('person.json', @person)
    save_to_json('rental.json', @rental)
  end

  def load_data
    @books = load_from_json('book.json')
    @people = load_from_json('person.json')
    @rentals = load_from_json('rental.json')
  end

  def save_to_json(file_name, data)
    File.write(file_name, JSON.generate(data))
  end

  def load_from_json(file_name)
    return [] unless File.exist?(file_name)

    JSON.parse(File.read(file_name))
  end
end
