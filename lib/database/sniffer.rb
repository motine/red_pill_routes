require 'time'
require 'csv'
require 'ostruct'

module Database
  class Sniffer < Base
    protected

    def parse_routes
      stretches = denormalize(read_sequences, read_node_times)
      return routes_from_stretches(stretches, read_route_entries)
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
          'sniffer')
      end
    end

    # reads sequences.csv and combines
    def denormalize(sequences, node_times)
      sequences.collect do |sequence|
        node_time = node_times[sequence.node_time_id]
        next if node_time.nil?
        Stretch.new(sequence.route_id, node_time.start_node, node_time.end_node, node_time)
      end.compact
    end

    def read_sequences
      read_csv('sequences.csv').collect do |row|
        OpenStruct.new(row.to_h)
      end
    end

    # returns a hash mapping the node_time_id to an openstruct with (start_node, end_node, duration).
    # duration is measured in seconds
    def read_node_times
      read_csv('node_times.csv').reduce({}) do |acc, row|
        acc[row['node_time_id']] = OpenStruct.new(
          start_node: row["start_node"],
          end_node: row["end_node"],
          duration: row["duration_in_milliseconds"].to_f / 1000)
        acc
      end
    end

    # returns a has mapping the route_id to OpenStructs with attribute time.
    # time is a preprocessed to be of type Time.
    def read_route_entries
      read_csv('routes.csv').reduce({}) do |acc, row|
        raise 'Currently only a time_zone with "UTC±00:00" is supported in sniffer\'s "route.csv"' if row['time_zone'] != "UTC±00:00"
        acc[row['route_id']] = OpenStruct.new(time: Time.parse(row['time']))
        acc
      end
    end

    def read_csv(filename)
      path = File.join(@absolute_folder_path, filename)
      CSV.read(path, headers: true, quote_char: '"', col_sep: ', ', encoding: 'utf-8')
    end
  end
end
