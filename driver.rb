require 'pry'

module Driver

  def display
  attributes = []
  query_components_array = []
    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end
    attributes.each do |a|
      front_dots = "." * (12 - a.length)
      back_dots = "." * (30 - ("#{self.send(a)}".length))
      puts "#{a}" + "#{front_dots}" + "#{back_dots}" + "#{self.send(a)}"
    end
    return
  end
  
  # def save
  #   attributes = []
  #   query_components_array = []
  #
  #   instance_variables.each do |i|
  #     attributes << i.to_s.delete("@")
  #   end
  #
  #   attributes.each do |a|
  #     value = self.send(a)
  #     if value.is_a?(Integer) || value.is_a?(Float)
  #       query_components_array << "#{a} = #{self.send(a)}"
  #     else
  #       query_components_array << "#{a} = '#{self.send(a)}'"
  #     end
  #   end
  # end

end

#-----------------------------------------
# Code to be implemented after thorough testing

#
# def display_attr
#  attributes = []
#  query_components_array = []
#
#  instance_variables.each do |i|
#    attributes << i.to_s.delete("@")
#  end
#
#  attributes.each do |a|
#    value = self.send(a)
#    if value.is_a?(Float)
#      front_spacer = " " * (12 - a.length)
#      back_spacer = " " * (49 - ("#{self.send(a)}".length))
#      puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "$#{self.send(a)}"
#    else
#      front_spacer = " " * (12 - a.length)
#      back_spacer = " " * (50 - ("#{self.send(a)}".length))
#      puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}"
#    end
#  end
#  puts "=" * 63
#  return
# end
#
#
#
# def format_many(array_of_objects)
#   count = 0
#   array_of_objects.each do |x|
#     count += 1
#     puts "Product #{count}:"
#     x.display_attr
#   end
# end
#
#
# def self.where_title_is(title)
#   results = DATABASE.execute("SELECT * FROM products WHERE title = '#{title}'")
#
#   results_as_objects = []
#
#   results.each do |r|     # r is a hash
#     # this loops through and creates an array of objects
#     results_as_objects << self.new(r)
#   end
#   results_as_objects
# end
#
#
# def self.where_author_is(author)
#   results = DATABASE.execute("SELECT * FROM products WHERE author = '#{author}'")
#   results.each do |x|
#     puts "#{x[0]}: #{x[2]} by #{x[3]}   (Quantity in stock: #{7})"
#   end
#
#   results_as_objects = []
#
#   results.each do |r|     # r is a hash
#     # this loops through and creates an array of objects
#     results_as_objects << self.new(r)
#   end
#   results_as_objects
# end
#
#
# def self.where_id_is(record_id)
#   results = DATABASE.execute("SELECT * FROM products WHERE id =
#                              #{record_id}")
#   record_details = results[0] # Hash of the record details.
#   z = self.new(record_details)
#   z.display_attr
# end