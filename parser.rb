#!/usr/bin/env ruby

require_relative 'lib/lib'

def main
  # database = RouteDatabase::Sentinels.new('sources/sentinels')
  # database = Database::Aggregator.new(
  #   Database::Loophole.new('sources/loopholes'),
  #   Database::Loophole.new('sources/loopholes'))
  puts(database.routes)
end

# it is crucial to set the timezone to UTC, so the parsing of the timestamps does work as intended.
ENV['TZ'] = 'UTC'

main