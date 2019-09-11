#!/usr/bin/env ruby

require_relative 'lib/lib'

def main
  database = Database::Aggregator.new(
    Database::Loophole.new('sources/loopholes'),
    Database::Sentinel.new('sources/sentinels'),
    Database::Sniffer.new('sources/sniffers'))
  puts(database.routes)
end

# it is crucial to set the timezone to UTC, so the parsing of the timestamps does work as intended.
ENV['TZ'] = 'UTC'

main