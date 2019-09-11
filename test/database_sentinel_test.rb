require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Sentinel do
  class SentinelTestDatabase < Database::Sentinel
    def retrieve_contents
      @contents = content_from_fixture('sentinels')
    end
  end

  describe "parse" do
    before do
      @route1 = Route.new("alpha", "gamma", Time.new(2030, 12, 31, 13, 00, 01, "+00:00"), Time.new(2030, 12, 31, 13, 00, 03, "+00:00"), "sentinels")
      @route2 = Route.new("delta", "gamma", Time.new(2030, 12, 31, 13, 00, 02, "+00:00"), Time.new(2030, 12, 31, 13, 00, 04, "+00:00"), "sentinels")
      @fixture_routes = [@route1, @route2]
    end

    it "it parses routes from fixtures correctly" do
      routes = SentinelTestDatabase.new.routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end
end
