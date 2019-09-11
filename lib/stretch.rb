class Stretch < Struct.new(:route_id, :start_node, :end_node, :metadata)
  # TODO: test retains metadata
  # TODO: test orders correctly
  # takes a list of stretches an orders them so that they connect with each other.
  # 
  # Example: 
  # stretches = [Stretch.new('b', 'c'), Stretch.new('a', 'b'), Stretch.new('c', 'd')]
  # Stretch.order(stretches)
  # => [#Stretch<('a', 'b')>, #Stretch<('b', 'c')>, #Stretch<('c', 'd')>]
  def self.order(stretches)
    stretches
    # TODO
  end
end
