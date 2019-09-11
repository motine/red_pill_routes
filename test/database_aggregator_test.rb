# frozen_string_literal: true

require_relative 'test_helper'

# please see README.md for notes on mocking data.

describe Database::Aggregator do
  class TestDatabase < Database::Base
    def initialize(routes)
      @routes = routes
    end

    def source
      'test'
    end
  end

  describe 'parse' do
    before do
      @route1 = Route.new('gamma', 'lambda', Time.new(2030, 12, 31, 13, 0, 4, '+00:00'), Time.new(2030, 12, 31, 13, 0, 6, '+00:00'), 'something')
      @route2 = Route.new('beta', 'lambda', Time.new(2030, 12, 31, 13, 0, 5, '+00:00'), Time.new(2030, 12, 31, 13, 0, 7, '+00:00'), 'other')
    end

    it 'it aggregates routes from multiple databases' do
      db1 = TestDatabase.new([@route1])
      db2 = TestDatabase.new([@route2])
      routes = Database::Aggregator.new([db1, db2]).routes
      routes.size.must_equal 2
      routes.must_include(@route1)
      routes.must_include(@route2)
    end
  end
end
