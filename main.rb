require 'pry'
require 'sqlite3'
require 'hirb'
require 'yaml'
require_relative 'db_setup.rb'
require_relative 'category.rb'
require_relative 'location.rb'
require_relative 'product.rb'
# require_relative "module"
# include Manage
#
#CLI Menu to facilitate the user interface...
puts "-" * 80
puts "Welcome to the FANTASTIC BOOKS Inventory Management Tool."
puts "Choose an action from the list below:"
users_choice = 0

until users_choice == 9 do
  sleep(2)
  puts
  puts "-" * 80
  puts "PRODUCT MANAGEMENT"
  puts "1. Add a new product"
  puts "2. Edit a product (e.g., change product genre, update quantity, change location, etc.)"
  puts "3. Delete a product"
  puts "4. Show products (e.g., by title, by genre, or by location, etc.)"
  puts "-" * 80
  puts "GENRE MANAGEMENT"
  puts "5. Add a new genre"
  puts "6. Delete a genre"
  puts "-" * 80
  puts "LOCATION MANAGEMENT"
  puts "7. Add a new location"
  puts "8. Delete a location"
  puts "-" * 80
  puts "9. Exit"
  puts
  users_choice = gets.chomp.to_i

#**********************************************************
  attributes_list = ["isbn", "title", "author", "description", "cost",
                     "price", "quantity", "category_id", "location_id"]
  attributes_hash = {"isbn" => nil, "title" => nil, "author" => nil,
                     "description" => nil, "cost" => nil, "price" => nil,
                     "quantity" => nil, "category_id" => nil, "location_id" => nil}

  if users_choice == 1
    attributes_list.each do |x|
      puts "Enter the #{x}:"
      user_input = gets.chomp
      # if user_input?(Integer)
      #   user_input = user_input
      # else user_input = ''
      attributes_hash[x] = user_input
    end
      x = Product.new(attributes_hash)
      x.insert
      puts "#{x} has now been added to the database."
      x.inspect 
  elsif users_choice == 2
    puts "How would you like to search for the item to edit:"
    puts "1. Author"
    puts "2. Title"
    user_input = gets.chomp.to_i
      if user_input == 1
        puts "Enter the Author (Example: 'Harper Lee')"
        author = gets.chomp.to_s
        result = Product.where_author_is(author)
        puts result.inspect
      elsif user_input == 2
        puts "Enter the Title (Example: 'To Kill a Mockingbird')"
        title = gets.chomp.to_s
        result = Product.where_title_is(title)
        puts result.inspect
      end
        puts "Which field would you like to edit?"
        puts "1. Author"
        puts "2. Title"
        puts "3. Description"
        puts "4. Price"
        puts "5. Cost"
        puts "6. Warehouse Location"
        puts "7. Genre"
        puts "8. Quantity"
        field_input = gets.chomp.to_i
          if field_input == 1
            put "Current author is: #{result.author}"
            puts "What is the new Author? (e.g., 'Harper Lee)"
            author_input = gets.chomp.to_s
            result.author = author_input
            result.save
            result
          elsif field_input == 2
            put "Current title is: #{result.title}"
            puts "What is the new Title? (e.g., 'To Kill a Mockingbird')"
            title_input = gets.chomp.to_s
            result.title = title_input
            result.save
            result
          elsif field_input == 3
            puts "Current description is: #{result.description}"
            puts "What is the new Description? (e.g., 'Hardcover')"
            description_input = gets.chomp.to_s
            result.description = description_input
            result.save
            result
          elsif field_input == 4
            puts "Current price is: #{result.price}"
            puts "What is the new Price? (e.g., 8.99)"
            price_input = gets.chomp.to_f
            result.price = price_input
            result.save
            result
          elsif field_input == 5
            puts "Current cost is: #{result.cost}"
            puts "What is the new Cost? (e.g., 2.99)"
            cost_input = gets.chomp.to_f
            result.cost = cost_input
            result.save
            result
          elsif field_input == 6
            puts "Current location is: #{result.location_id}"
            puts "What is the new Warehouse location for this product? 
                 (e.g., Dallas TX)"
            # x = DATABASE.execute("SELECT * from locations")
            city_input = gets.chomp.to_s
            x = DATABASE.execute("SELECT id from locations WHERE city =
                                 '#{city_input}'")
            x = x[0]
            x = x["id"]
            result.location_id = x
            result.save
            result
          elsif field_input == 7
            puts "Current genre is: #{result.category_id}"
            puts "What is the new Genre for this product? (e.g., 'horror')"
            genre_input = gets.chomp.to_s
            x = DATABASE.execute("SELECT id from locations WHERE city = 
                                 '#{city_input}'")
            x = x[0]
            x = x["id"]
            result.category_id = x
            result.save
            result
          elsif field_input == 8
            puts "Current quantity is: #{result.quantity}"
            puts "What is the new Quantity for this product? (e.g., 10)"
            quantity_input = gets.chomp.to_i
            result.quantity
            result.save
            result
          end
  elsif users_choice == 3
    puts "How would you like to search for the item you want to delete:"
    puts "1. Author"
    puts "2. Title"
    user_input = gets.chomp.to_i
      if user_input == 1
        puts "Enter the Author (Example: 'Harper Lee')"
        author = gets.chomp.to_s
        result = Product.where_author_is(author)
        result.inspect
        puts "Which of these titles by #{author} would you like to delete?"
        title = gets.chomp.to_s
        puts "Are you sure you want to delete #{result}? (y/n)"
        yes_no = gets.chomp.to_s.downcase
          if yes_no = y
          Product.delete(title)
          puts "#{title} has been deleted."
          end
      elsif user_input == 2
        puts "Enter the Title to delete (Example: 'To Kill a Mockingbird')"
        title = gets.chomp.to_s
        result = Product.where_title_is(title)
        puts "Are you sure you want to delete #{result.title}? (y/n)"
        yes_no = gets.chomp.to_s.downcase
          if yes_no = y
          Product.delete(title)
          puts "#{title} has been deleted."
          end
      end
  elsif users_choice == 4
    puts "How would you like to view products?"
    puts "1. All products."
    puts "2. All products in a certain warehouse."
    puts "3. All products in a certain genre."
    view_input = gets.chomp.to_i
    if view_input == 1
      x = Product.all
      puts x
    elsif view_input == 2
      puts "What warehouse location would you like to see? (e.g., 'Omaha NE')"
      city_input = gets.chomp.to_s
      x = Product.location(city_input)
        if x == nil
          puts "There are no products at this location."
        else  
          x.inspect
        end
    elsif view_input == 3
      puts "What genre would you like to view? (e.g., 'suspense')"
      genre_input = gets.chomp.to_s
      x = Product.location(genre_input)
        if x == nil
          puts "There are no products at this location."
        else  
          x.inspect
        end
    end
  elsif users_choice == 5
    puts "What is the name of the new genre? (e.g., 'graphic novel')"
    new_genre_input = gets.chomp.to_s
    x = Category.new({'genre' => "#{new_genre_input}"})
    x.insert
    puts "#{new_genre_input} has been added to the database."
    x.inspect
  elsif users_choice == 6
    puts "What is the name of the genre you want to delete? (e.g., 'romance')"
    delete_genre_input = gets.chomp.to_s
    puts "Warning: If products are assigned to this genre, it cannot be deleted."
    x = DATABASE.execute("SELECT id FROM categories WHERE genre = '#{delete_genre_input}'")
    Category.delete(x)
  elsif users_choice == 7
    puts "What is the name of the new warehouse location? (e.g., 'Sioux City IA')"
    new_location_input = gets.chomp.to_s
    x = Location.new({'city' => "#{new_location_input}"})
    x.insert
    puts "#{new_location_input} has been added to the database."
    x.inspect
  elsif users_choice == 8
    puts "What is the name of the location you want to delete? (e.g., 'Sioux City IA')"
    delete_location_input = gets.chomp.to_s
    puts "Warning: If products are assigned to this location, it cannot be deleted."
    x = DATABASE.execute("SELECT id FROM locations WHERE city = '#{delete_location_inDput}'")
    Location.delete(x)
  elsif users_choice == 9
    puts "Thank you. Please come again!"
  end
end
binding.pry













#
#
#   title = gets.chomp.to_s
#   puts "Enter the author:"
#   author = gets.chomp.to_s
#
#
#   puts "Enter the name of the restaurant:"
#   restaurant = gets.chomp.to_s
#   puts "Enter the names of the people who are attending this event. (Enter the names as a comma-separated list.)"
#   attendees = gets.chomp
#   # attendees = names.split(", ")
#   binding.pry
#   dc.create_new_event(date, restaurant, *attendees)
# end
# elsif users_choice == 2
#   puts "Enter the amount of the meal:"
#   amt = gets.chomp.to_i
#   puts "Enter the amount of the tip. (Example for a 20% tip, enter 20.)"
#   tip = gets.chomp.to_i
#   dc.reconcile(amt, tip)
# elsif users_choice == 3
#   puts "Current club members include:"
#   dc.members.each do |name, amt|
#     puts "#{name}"
#   end
# elsif users_choice == 4
#   #add a new member to the club
#   puts "Who would you like to add to your dinner club:"
#   name = gets.chomp.to_s
#   dc.add_member(name)
#   puts "Current members now include:"
#   dc.members.each do |name, amt|
#     puts "#{name}"
#   end
# elsif users_choice == 5
#   puts "Please come again!"
# end