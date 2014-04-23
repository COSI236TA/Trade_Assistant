module RulesHelper
  def get_properties
    return Property.all.slice(0, 21).map { |p| [p.d_name, p.id] }
  end
end
