class BookHandler
  def handle_list_books(app)
    app.list_all_books
  end

  def handle_create_book(app)
    puts 'Enter the book title:'
    title = gets.chomp

    puts 'Enter the book author:'
    author = gets.chomp

    app.create_book(title, author)
    puts 'Book created successfully.'
  end
end
