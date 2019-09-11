module Database
  class Aggregator < Base
    def initialize(*databases)
      @databases = databases
    end

    def routes
      @databases.flat_map { |database| database.routes }
    end
  end
end