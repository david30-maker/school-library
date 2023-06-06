class PersonHandler
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

  def handle_list_rentals_for_person(app)
    puts "Enter the person ID (see ID in the list below): \n"
    app.list_all_people
    person_id = gets.chomp.to_i

    app.list_rentals_for_person(person_id)
  end
end
