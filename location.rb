require_relative 'driver.rb'

class Location
  include Driver
  attr_reader :id
  attr_accessor :city
  
  def initialize(options)
    @id   = options["id"]
    @city = options["city"]
  end

  def insert
    DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  def self.all
    x = DATABASE.execute("SELECT * FROM locations")
    x.each do |x|
        puts "#{x[0]}: #{x[1]}"
    end
  end
  
  def self.delete(id_to_remove)
# SELECT * FROM products INNER JOIN categories ON Products.category_id = Categories.id WHERE genre = "adventure";
 
    x = DATABASE.execute("SELECT location_id FROM products WHERE location_id = #{id_to_remove}")
    if x.length == 0
      DATABASE.execute("DELETE FROM locations WHERE id = #{id_to_remove}")
    else
      DATABASE.execute("SELECT * FROM products WHERE location_id = #{id_to_remove}")
    end
  end

end