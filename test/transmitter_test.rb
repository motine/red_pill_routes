# frozen_string_literal: true

require_relative 'test_helper'

require 'ostruct'

describe Transmitter do
  before do
    @route1 = Route.new('gamma', 'lambda', Time.new(2030, 12, 31, 13, 0, 4, '+00:00'), Time.new(2030, 12, 31, 13, 0, 6, '+00:00'), 'mysource')
    @route2 = Route.new('beta', 'lambda', Time.new(2030, 12, 31, 13, 0, 5, '+00:00'), Time.new(2030, 12, 31, 13, 0, 7, '+00:00'), 'mysource')
    @routes = [@route1, @route2]
  end

  describe 'transmit' do
    it 'calls url and adds parameters correctly' do
      transmitter = Transmitter.new('http://example.net/routes', 'secret')

      argument_validator = proc do |url, options|
        url.must_equal "http://example.net/routes"
        options[:query].must_equal({
          passphrase: 'secret',
          source: 'mysource',
          start_node: 'gamma', end_node: 'lambda',
          start_time: '2030-12-31T13:00:04', end_time: '2030-12-31T13:00:06'
        })
        OpenStruct.new(code: 201)
      end

      HTTParty.stub(:post, argument_validator) do
        transmitter.transmit(@route1)
      end
    end

    it 'fails when not status code 201' do
      transmitter = Transmitter.new('http://example.net/routes', 'secret')

      HTTParty.stub(:post, OpenStruct.new(code: 500)) do
        assert_raises do
          transmitter.transmit(@route1)
        end
      end
    end
  end

  describe 'transmit_all' do
    it 'calls transmit for each route' do
      transmitter = Transmitter.new('', '')
      calls = 0
      transmitter.stub(:transmit, proc { calls += 1 }) do
        transmitter.transmit_all(@routes)
      end
      calls.must_equal 2
    end
  end
end
