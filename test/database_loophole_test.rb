# frozen_string_literal: true

require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Loophole do
  class LoopholeTestDatabase < Database::Loophole
    def retrieve_contents
      @contents = content_from_fixture('loopholes')
    end
  end

  describe 'parse' do
    before do
      @route1 = Route.new('gamma', 'lambda', Time.new(2030, 12, 31, 13, 0, 4, '+00:00'), Time.new(2030, 12, 31, 13, 0, 6, '+00:00'), 'loopholes')
      @route2 = Route.new('beta', 'lambda', Time.new(2030, 12, 31, 13, 0, 5, '+00:00'), Time.new(2030, 12, 31, 13, 0, 7, '+00:00'), 'loopholes')
      @fixture_routes = [@route1, @route2]
    end

    it 'it parses routes from fixtures correctly' do
      routes = LoopholeTestDatabase.new.routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end
end
