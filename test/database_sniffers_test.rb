# frozen_string_literal: true

require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Sniffer do
  class SnifferTestDatabase < Database::Sniffer
    def retrieve_contents
      @contents = content_from_fixture('sniffers')
    end
  end

  describe 'parse' do
    before do
      @route1 = Route.new('lambda', 'omega', Time.new(2030, 12, 31, 13, 0, 6, '+00:00'), Time.new(2030, 12, 31, 13, 0, 9, '+00:00'), 'sniffers')
      @route2 = Route.new('lambda', 'omega', Time.new(2030, 12, 31, 13, 0, 7, '+00:00'), Time.new(2030, 12, 31, 13, 0, 9, '+00:00'), 'sniffers')
      @fixture_routes = [@route1, @route2]
    end

    it 'it parses routes from fixtures correctly' do
      routes = SnifferTestDatabase.new.routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end
end
