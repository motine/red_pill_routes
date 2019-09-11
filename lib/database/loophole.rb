require 'time'
require 'json'
require 'ostruct'

module Database
  class Loophole < Base

    def source
      'loopholes'
    end

    protected

    def parse_routes
      stretches = denormalize(route_entries, node_pairs)
      @routes = routes_from_stretches(stretches)
    end

    private

    def routes_from_stretches(stretches)
      stretches.group_by(&:route_id).collect do |_route_id, group_streches|
        sorted = Stretch.order(group_streches)
        Route.new(
          sorted.first.start_node, sorted.last.end_node,
          sorted.first.metadata.start_time, sorted.last.metadata.end_time,
          source)
      end
    end

    # returns a list of Stretches by combining the information of node_pairs and route_entries
    def denormalize(route_entries, node_pairs)
      route_entries.collect do |entry|
        node_pair = node_pairs[entry.node_pair_id]
        next nil if node_pair.nil?
        Stretch.new(entry.route_id, node_pair.start_node, node_pair.end_node, entry)
      end.compact
    end

    # returns a hash by reading from `node_pairs.json`.
    # the key is the id of the node_pair, the value an openstruct with start_node and end_node set
    def node_pairs
      json_array('node_pairs.json').reduce({}) { |acc, pair| 
        acc[pair.id] = pair
        acc
      }
    end

    # returns a list of openstructs by reading from `routes.json` (format see in json file).
    # start_time and end_time are preprocessed
    def route_entries
      json_array('routes.json').collect do |entry|
        entry.start_time = Time.parse(entry.start_time)
        entry.end_time = Time.parse(entry.end_time)
        entry
      end
    end
  end
end
