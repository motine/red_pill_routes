require 'time'
require 'csv'
require 'ostruct'

module Database
  class Sentinel < Base

    def source
      'sentinels'
    end

    protected

    def parse_routes
      @routes = routes_from_entries(entries)
    end

    private

    def routes_from_entries(entries)
      entries.group_by(&:route_id).collect do |_route_id, route_entries|
        next nil if route_entries.size == 1 # routes with no hop in between are bad
        sorted = route_entries.sort_by(&:index)
        Route.new(
          sorted.first.node, sorted.last.node,
          sorted.first.time, sorted.last.time,
          'sentinels')
      end.compact
    end

    # returns a list of OpenStructs with attributes route_id, node, index, time.
    # time is a preprocessed to be of type Time.
    # index is a preprocessed to be an integer (important for sorting later).
    def entries
      csv_content('routes.csv').collect do |entry|
        entry.time = Time.parse(entry.time).utc
        entry.index = entry.index.to_i
        entry
      end
    end
  end
end
