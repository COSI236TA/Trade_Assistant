module RulesHelper
  def get_properties
    return Property.where("id <= 21").map do |p|
      d_name = p.d_name.split.map(&:capitalize).join(' ')
      [d_name, p.id] 
   end
  end
end
