module Database
  class Aggregator
    def initialize(*databases)
      @databases = databases
    end

    def routes
      @databases.flat_map { |database| database.routes }
    end
  end
end