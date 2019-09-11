require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Sentinel do
  describe "parse" do
    before do
      @route1 = Route.new("alpha", "gamma", Time.new(2030, 12, 31, 13, 00, 01, "+00:00"), Time.new(2030, 12, 31, 13, 00, 03, "+00:00"), "sentinel")
      @route2 = Route.new("delta", "gamma", Time.new(2030, 12, 31, 13, 00, 02, "+00:00"), Time.new(2030, 12, 31, 13, 00, 04, "+00:00"), "sentinel")
      @route3 = Route.new("zeta", "zeta", Time.new(2030, 12, 31, 13, 00, 02, "+00:00"), Time.new(2030, 12, 31, 13, 00, 02, "+00:00"), "sentinel")
      @fixture_routes = [@route1, @route2, @route3]
    end

    it "it parses routes from fixtures correctly" do
      routes = Database::Sentinel.new('test/fixtures/sentinels').routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end

  # depending on the stability of the input data, we could write much more tests and validate the data when consuming.
end
