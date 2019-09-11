# frozen_string_literal: true

require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Sentinel do
  describe 'parse' do
    before do
      @route1 = Route.new('alpha', 'gamma', Time.new(2030, 12, 31, 13, 0, 1, '+00:00'), Time.new(2030, 12, 31, 13, 0, 3, '+00:00'), 'sentinels')
      @route2 = Route.new('delta', 'gamma', Time.new(2030, 12, 31, 13, 0, 2, '+00:00'), Time.new(2030, 12, 31, 13, 0, 4, '+00:00'), 'sentinels')
      @fixture_routes = [@route1, @route2]
    end

    it 'it parses routes from fixtures correctly' do
      routes = Database::Sentinel.new(Loader::FolderFromDisk.new(fixture_base_path)).routes
      routes.size.must_equal @fixture_routes.size
      @fixture_routes.each { |fixture| routes.must_include(fixture) }
    end
  end
end
