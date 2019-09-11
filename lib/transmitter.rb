require 'httparty'

class Transmitter
  URL = 'https://challenge.distribusion.com/the_one/routes'
  PASSPHRASE = 'Kans4s-i$-g01ng-by3-bye'

  def self.transmit_all(routes)
    routes.each do |route|
      Transmitter.transmit(route)
    end
  end

  def self.transmit(route)
    params = {
      passphrase: PASSPHRASE,
      source: route.source,
      start_node: route.start_node, end_node: route.end_node,
      start_time: format_time(route.start_time), end_time: format_time(route.end_time)
    }
    response = HTTParty.post(URL, query: params, headers: { 'Accept': 'application/json' }) # for debugging add: logger: Logger.new(STDOUT), log_level: :debug, log_format: :curl
    raise "Could not post the route, did not respond with status code created\ncode:#{response.code}\nroute: #{route.inspect}\n\nresponse:#{response}" unless response.code == 201
  end

  private # this private clause has only informational value

  def self.format_time(time)
    time.strftime("%Y-%m-%dT%H:%M:%S")
  end
end
