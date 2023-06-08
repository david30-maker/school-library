require 'json'

class SaveAppData
  attr_reader :app

  def save_data(app)
    save_books_to_json('books.json', app.books)
    save_people_to_json('people.json', app.people)
    save_rentals_to_json('rentals.json', app.rentals)
  end

  def save_books_to_json(file_name, data)
    object = data.map do |book|
      { id: book.id,
        title: book.title,
        author: book.author }
    end
    # File.open('books.json', 'w') do |file|
    File.write(file_name, JSON.pretty_generate(object))
  end

  def save_people_to_json(file_name, data)
    object = data.map do |person|
      case person.class.name
      when 'Student'
        {
          id: person.id,
          name: person.name,
          age: person.age,
          classroom: person.classroom.label
        }
      when 'Teacher'
        {
          id: person.id,
          name: person.name,
          age: person.age,
          specialization: person.specialization
        }
      end
    end
    # File.open('persons.json', 'w') do |file|
    File.write(file_name, JSON.pretty_generate(object))
  end

  def save_rentals_to_json(file_name, data)
    object = data.map do |rental|
      {
        id: rental.id,
        book_id: rental.book.id,
        person_id: rental.person.id,
        date: rental.date
      }
    end
    # File.open('rentals.json', 'w') do |file|
    File.write(file_name, JSON.pretty_generate(object))
  end
end
