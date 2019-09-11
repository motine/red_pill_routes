require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Loophole do
  describe "parse" do
    before do
      @route_1 = Route.new("gamma", "lambda", Time.new(2030, 12, 31, 13, 00, 04, "+00:00"), Time.new(2030, 12, 31, 13, 00, 06, "+00:00"), "loophole")
      @route_2 = Route.new("beta", "lambda", Time.new(2030, 12, 31, 13, 00, 05, "+00:00"), Time.new(2030, 12, 31, 13, 00, 07, "+00:00"), "loophole")
    end

    it "it parses routes from fixtures correctly" do
      routes = Database::Loophole.new('test/fixtures/loopholes').routes
      routes.size.must_equal 2
      routes.must_include(@route_1)
      routes.must_include(@route_2)
    end
  end
  # TODO: write more tests here
end
