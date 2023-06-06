class RentalHandler
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
end
