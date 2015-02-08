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

end


#   def display
#     x = {"id"=>1, "city"=>"Atlanta GA", 0=>1, 1=>"Atlanta GA"}
# {"id"=>2, "city"=>"Dallas TX", 0=>2, 1=>"Dallas TX"}
# {"id"=>3, "city"=>"Omaha NE", 0=>3, 1=>"Omaha NE"}
# {"id"=>4, "city"=>"Seattle WA", 0=>4, 1=>"Seattle WA"}
# {"id"=>5, "city"=>"San Francisco CA", 0=>5, 1=>"San Francisco CA"}
# {"id"=>7, "city"=>"Aberdeen SD", 0=>7, 1=>"Aberdeen SD"}
# {"id"=>8, "city"=>"Juneau AK", 0=>8, 1=>"Juneau AK"}
#
#   end
  
  