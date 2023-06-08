require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

class App
  attr_reader :books, :people, :rentals

  DATA_DIR = 'data'.freeze

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

  private

  def load_data
    @books = load_books_from_json('books.json')
    @people = load_people_from_json('people.json')
    @rentals = load_rentals_from_json('rentals.json')
  end

  def load_books_from_json(file_name)
    if File.exist?(file_name)
      file_content = File.read(file_name)
      object_properties = JSON.parse(file_content)
      stored_objects = object_properties.map do |props|
        Book.new(props['id'], props['title'], props['author'])
      end
      @books = stored_objects
    else
      @books = []
    end
  rescue JSON::ParserError => e
    puts "Error parsing #{file_name}: #{e.message}"
    []
  end

  def load_people_from_json(file_name)
    if File.exist?(file_name)
      file_content = File.read(file_name)
      object_properties = JSON.parse(file_content)
      stored_objects = object_properties.map do |props|
        if props['classroom']
          Student.new(props['id'], props['name'], props['age'], props['classroom'])
        else
          Teacher.new(props['id'], props['name'], props['age'], props['specialization'])
        end
      end
      @people = stored_objects
    else
      @people = []
    end
  rescue JSON::ParserError => e
    puts "Error parsing #{file_name}: #{e.message}"
    []
  end

  def load_rentals_from_json(file_name)
    if File.exist?(file_name)
      file_content = File.read(file_name)
      object_properties = JSON.parse(file_content)
      stored_objects = object_properties.map do |props|
        rental_book = @books.find { |book| book.id == props['book_id'] }
        rental_person = @people.find { |person| person.id == props['person_id'] }
        Rental.new(props['id'], rental_book, rental_person, props['date'])
      end
      @rentals = stored_objects
    else
      @rentals = []
    end
  rescue JSON::ParserError => e
    puts "Error parsing #{file_name}: #{e.message}"
    []
  end
end
