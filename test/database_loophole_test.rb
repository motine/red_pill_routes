require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Loophole do
  describe "parse" do
    before do
      @route1 = Route.new("gamma", "lambda", Time.new(2030, 12, 31, 13, 00, 04, "+00:00"), Time.new(2030, 12, 31, 13, 00, 06, "+00:00"), "loophole")
      @route2 = Route.new("beta", "lambda", Time.new(2030, 12, 31, 13, 00, 05, "+00:00"), Time.new(2030, 12, 31, 13, 00, 07, "+00:00"), "loophole")
      @fixture_routes = [@route1, @route2]
    end

    it "it parses routes from fixtures correctly" do
      routes = Database::Loophole.new('test/fixtures/loopholes').routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end
  # TODO: write more tests here
end