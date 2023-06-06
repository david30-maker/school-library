require_relative 'app'
require_relative 'book_handler'
require_relative 'person_handler'
require_relative 'rental_handler'

def main
  app = App.new
  book_handler = BookHandler.new
  person_handler = PersonHandler.new
  rental_handler = RentalHandler.new

  loop do
    display_menu_options
    option = user_option
    break if option == 7

    process_option(option, app, book_handler, person_handler, rental_handler)
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

def process_option(option, app, book_handler, person_handler, rental_handler)
  case option
  when 1
    book_handler.handle_list_books(app)
  when 2
    person_handler.handle_list_people(app)
  when 3
    person_handler.handle_create_person(app)
  when 4
    book_handler.handle_create_book(app)
  when 5
    rental_handler.handle_create_rental(app)
  when 6
    person_handler.handle_list_rentals_for_person(app)
  else
    puts 'Invalid option. Please try again.'
  end
end
