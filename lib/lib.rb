# it is crucial to set the timezone to UTC, so the parsing of the timestamps does work as intended.
ENV['TZ'] = 'UTC'

require_relative 'route.rb'
require_relative 'stretch.rb'
require_relative 'database/base.rb'
require_relative 'database/aggregator.rb'
require_relative 'database/loophole.rb'
require_relative 'database/sentinel.rb'
require_relative 'database/sniffer.rb'
require_relative 'transmitter.rb'
