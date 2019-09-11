# frozen_string_literal: true

module Database
  # Aggregates the routes of multiple databases.
  class Aggregator < Base
    def initialize(databases)
      @databases = databases
    end

    def routes
      @databases.flat_map(&:routes)
    end
  end
end
