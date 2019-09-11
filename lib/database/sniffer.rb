require 'time'
require 'csv'
require 'ostruct'

module Database
  class Sniffer < Base

    def source
      'sniffers'
    end

    protected

    def parse_routes
      stretches = gather_stretches
      @routes = routes_from_stretches(stretches, route_entries)
    end

    private

    def routes_from_stretches(stretches, route_start_times)
      stretches.group_by(&:route_id).collect do |route_id, group_streches|
        sorted = Stretch.order(group_streches)
        start_time = route_start_times[route_id].time
        route_duration = sorted.sum { |stretch| stretch.metadata.duration }
        Route.new(
          sorted.first.start_node, sorted.last.end_node,
          start_time, start_time + route_duration,
          source)
      end
    end

    # Reads sequences and node_times and combines them to stretches.
    def gather_stretches
      sequences.collect do |sequence|
        node_time = node_times[sequence.node_time_id]
        next if node_time.nil?
        Stretch.new(sequence.route_id, node_time.start_node, node_time.end_node, node_time)
      end.compact
    end

    def sequences
      csv_content('sequences.csv')
    end

    # Returns a hash mapping the node_time_id to an OpenStruct with (start_node, end_node, duration).
    # duration is measured in seconds.
    def node_times
      @node_times ||= csv_content('node_times.csv').reduce({}) do |acc, row|
        row.duration = row.duration_in_milliseconds.to_f / 1000
        acc[row.node_time_id] = row
        acc
      end
    end

    # Returns a has mapping the route_id to OpenStructs with attribute time.
    # time is a preprocessed to be of type Time.
    def route_entries
      csv_content('routes.csv').reduce({}) do |acc, row|
        raise 'Currently only a time_zone with "UTC±00:00" is supported in sniffer\'s "routes.csv"' if row.time_zone != "UTC±00:00"
        acc[row.route_id] = OpenStruct.new(time: Time.parse(row.time))
        acc
      end
    end
  end
end
