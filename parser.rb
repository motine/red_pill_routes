#!/usr/bin/env ruby

require_relative 'lib/lib'

def main
  logger = Logger.new(STDOUT)
  
  logger.info("Reading data from files")
  database = Database::Aggregator.new(
    Database::Loophole.new('sources/loopholes'),
    Database::Sentinel.new('sources/sentinels'),
    Database::Sniffer.new('sources/sniffers'))
  logger.info("Found #{database.routes.size} routes.")
  
  logger.info("Will post the routes now...")
  Transmitter.transmit_all(database.routes)
  logger.info("successfully posted")
end

# it is crucial to set the timezone to UTC, so the parsing of the timestamps does work as intended.
ENV['TZ'] = 'UTC'

main
