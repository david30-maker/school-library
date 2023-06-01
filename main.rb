require_relative 'app'

def main
  app = App.new

  loop do
    puts 'Welcome to the Console App!'
    puts 'Please choose an option:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit the app'

    option = get_user_option

    process_option(option, app)
  end
end

def user_option
  print 'Enter your choice: '
  gets.chomp.to_i
end

def process_option(option, app)
  option_handlers = {
    1 => :handle_list_books,
    2 => :handle_list_people,
    3 => :handle_create_person,
    4 => :handle_create_book,
    5 => :handle_create_rental,
    6 => :handle_list_rentals_for_person,
    7 => :handle_quit_app
  }

  handler = option_handlers[option]
  if handler
    send(handler, app)
  else
    puts 'Invalid option. Please try again.'
  end
end

def create_person(app)
  print "Enter the person's name: "
  name = gets.chomp

  print "Enter the person's age: "
  age = gets.chomp.to_i

  print 'Is the person a teacher? (Y/N): '
  is_teacher = gets.chomp.downcase == 'y'

  if is_teacher
    print "Enter the teacher's specialization: "
    specialization = gets.chomp
    app.create_teacher(name, age, specialization)
    puts 'Teacher created successfully.'
  else
    print 'Does the person have parent permission? (Y/N): '
    has_permission = gets.chomp.downcase == 'y'
    app.create_student(name, age, has_permission)
    puts 'Student created successfully.'
  end
end

def create_book(app)
  print "Enter the book's title: "
  title = gets.chomp

  print "Enter the author's name: "
  author = gets.chomp

  app.create_book(title, author)
  puts 'Book created successfully.'
end

def create_rental(app)
  print "Enter the person's ID: "
  person_id = gets.chomp.to_i

  print "Enter the book's ID: "
  book_id = gets.chomp.to_i

  print 'Enter the rental date (YYYY-MM-DD): '
  rental_date = gets.chomp

  app.create_rental(person_id, book_id, rental_date)
  puts 'Rental created successfully.'
end

def list_rentals_for_person(app)
  print "Enter the person's ID: "
  person_id = gets.chomp.to_i

  rentals = app.rentals_for_person(person_id)

  if rentals.empty?
    puts "No rentals found for the person with ID #{person_id}."
  else
    puts "Rentals for the person with ID #{person_id}:"
    rentals.each do |rental|
      puts "Rental ID: #{rental.id}"
      puts "Book: #{rental.book.title} by #{rental.book.author}"
      puts "Rental Date: #{rental.date}"
      puts '------'
    end
  end
end

main
