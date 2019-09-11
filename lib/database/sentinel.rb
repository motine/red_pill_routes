require 'time'
require 'csv'
require 'ostruct'

module Database
  class Sentinel < Base
    protected

    def parse_routes
      entries = read_entries
      return routes_from_entries(entries)
    end

    private

    def routes_from_entries(entries)
      entries.group_by(&:route_id).collect do |_route_id, route_entries|
        sorted = route_entries.sort_by(&:index)
        Route.new(
          sorted.first.node, sorted.last.node,
          sorted.first.time, sorted.last.time,
          'sentinel')
      end
    end

    # returns a list of OpenStructs with attributes route_id, node, index, time.
    # time is a preprocessed to be of type Time.
    # index is a preprocessed to be an integer (important for sorting later).
    def read_entries
      path = File.join(@absolute_folder_path, 'routes.csv')
      CSV.read(path, headers: true, quote_char: '"', col_sep: ', ').collect do |row|
        entry = OpenStruct.new(row.to_h)
        entry.time = Time.parse(entry.time).utc
        entry.index = entry.index.to_i
        entry
      end
    end
  end
end
