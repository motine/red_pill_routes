# A value objeect for a route.
class Route < Struct.new(:start_node, :end_node, :start_time, :end_time, :source)
  # we could add validations here for node names and enforce the Time type.
end
