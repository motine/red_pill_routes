# TODO: create a stretch list or an edges class
class Stretch < Struct.new(:route_id, :start_node, :end_node, :metadata)
  # takes a list of stretches an orders them so that they connect with each other.
  # 
  # Limitation:
  # The stretches must have exactly one possibility to connect them.
  # If this should not hold true anymore, we would need to implement something a shortest path algorithm
  #
  # Example: 
  # stretches = [Stretch.new('b', 'c'), Stretch.new('a', 'b'), Stretch.new('c', 'd')]
  # Stretch.order(stretches)
  # => [#Stretch<('a', 'b')>, #Stretch<('b', 'c')>, #Stretch<('c', 'd')>]
  def self.order(stretches)
    edges = Stretch.graph_edges_from(stretches)
    start_node = Stretch.start_node_with_no_incoming(edges)
    
    result = []
    while true do
      stretch = stretches.find { |s| s.start_node == start_node }
      break unless stretch # there is no more stretch, so we must be at the end
      result << stretch
      start_node = stretch.end_node
    end
    result
  end

  protected # this protected has only informational value

  # creates a hash of the form { start_node => end_node }
  def self.graph_edges_from(stretches)
    stretches.reduce({}) do |acc, stretch|
      raise "there is more than one possibility to connect: #{edges.inspect}" if acc[stretch.start_node]
      acc[stretch.start_node] = stretch.end_node
      acc
    end
  end

  def self.start_node_with_no_incoming(edges)
    start_nodes = edges.keys.keep_if do |node|
      !edges.any? { |_start_node, end_node| end_node == node }
    end
    raise "there is no possible start point while ordering stretches: #{edges.inspect}" if start_nodes.size < 1
    return start_nodes.first
  end
end
