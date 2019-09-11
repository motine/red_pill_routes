class Route < Struct.new(:start_node, :end_node, :start_time, :end_time, :source)
  # TODO: add validation for start and end time.
end
