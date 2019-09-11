require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Aggregator do
  describe "parse" do
    before do
      @route_1 = Route.new("gamma", "lambda", Time.new(2030, 12, 31, 13, 00, 04, "+00:00"), Time.new(2030, 12, 31, 13, 00, 06, "+00:00"), "something")
      @route_2 = Route.new("beta", "lambda", Time.new(2030, 12, 31, 13, 00, 05, "+00:00"), Time.new(2030, 12, 31, 13, 00, 07, "+00:00"), "other")
    end

    it "it aggregates routes from multiple databases" do
      db_class = Class.new(Database::Base) do def parse_routes; []; end end
      db1 = db_class.new(''); db1.routes = [@route_1]
      db2 = db_class.new(''); db2.routes = [@route_2]
      routes = Database::Aggregator.new(db1, db2).routes
      routes.size.must_equal 2
      routes.must_include(@route_1)
      routes.must_include(@route_2)
    end
  end
end
