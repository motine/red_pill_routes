# frozen_string_literal: true

require 'httparty'

# Transmits the routes to the given endpoint, using the given passphrase.
class Transmitter
  def initialize(url, passphrase)
    @url = url
    @passphrase = passphrase
  end

  def transmit_all(routes)
    routes.each do |route|
      transmit(route)
    end
  end

  def transmit(route)
    params = {
      passphrase: @passphrase,
      source: route.source,
      start_node: route.start_node, end_node: route.end_node,
      start_time: format_time(route.start_time), end_time: format_time(route.end_time)
    }
    response = HTTParty.post(@url, query: params, headers: { 'Accept': 'application/json' }) # for debugging add: logger: Logger.new(STDOUT), log_level: :debug, log_format: :curl
    raise "Could not post the route, did not respond with status code created\ncode:#{response.code}\nroute: #{route.inspect}\n\nresponse:#{response}" unless response.code == 201
  end

  private

  def format_time(time)
    time.strftime('%Y-%m-%dT%H:%M:%S')
  end
end
