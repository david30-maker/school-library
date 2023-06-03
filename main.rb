require_relative 'app'

def main
  app = App.new
  loop do
    display_menu_options
    option = user_option
    break if option == 7

    process_option(option, app)
    puts "\n"
    puts '****************************************************************************'
    puts "\n"
  end
  puts 'Quitting the app...'
end

def display_menu_options
  puts 'Welcome to the Console App!'
  puts 'Please choose an option:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List rentals for a person'
  puts '7. Quit the app'
end

def user_option
  print 'Enter your choice: '
  gets.chomp.to_i
end

def process_option(option, app)
  case option
  when 1
    handle_list_books(app)
  when 2
    handle_list_people(app)
  when 3
    handle_create_person(app)
  when 4
    handle_create_book(app)
  when 5
    handle_create_rental(app)
  when 6
    handle_list_rentals_for_person(app)
  else
    puts 'Invalid option. Please try again.'
  end
end

def handle_list_books(app)
  app.list_all_books
end

def handle_list_people(app)
  app.list_all_people
end

def handle_create_person(app)
  puts 'Enter the person name:'
  name = gets.chomp

  puts "\nEnter the person age:"
  age = gets.chomp.to_i

  puts "\nEnter the person type (student/teacher):"
  type = gets.chomp.downcase

  app.create_person(name, age, type)
  puts 'Person created successfully.'
end

def handle_create_book(app)
  puts 'Enter the book title:'
  title = gets.chomp

  puts 'Enter the book author:'
  author = gets.chomp

  app.create_book(title, author)
  puts 'Book created successfully.'
end

def handle_create_rental(app)
  puts "Select a book from the following list by number: \n"
  app.list_all_books
  book_index = gets.chomp.to_i

  puts "Select a person from the following list by number (not ID): \n"
  app.list_all_people
  person_index = gets.chomp.to_i

  puts 'Enter the rental date (YYYY-MM-DD):'
  rental_date = gets.chomp

  app.create_rental(book_index, person_index, rental_date)
end

def handle_list_rentals_for_person(app)
  puts "Enter the person ID (see ID in the list below): \n"
  app.list_all_people
  person_id = gets.chomp.to_i

  app.list_rentals_for_person(person_id)
end

main
