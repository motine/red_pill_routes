#!/usr/bin/env ruby

require_relative 'lib/lib'

URL = 'https://challenge.distribusion.com/the_one/routes'
PASSPHRASE = 'Kans4s-i$-g01ng-by3-bye'

def main
  logger = Logger.new(STDOUT)
  
  logger.info("Reading data from files")
  # database = Database::Aggregator.new(
  #   Database::Loophole.new(URL, PASSPHRASE),
  #   Database::Sentinel.new(URL, PASSPHRASE),
  #   Database::Sniffer.new(URL, PASSPHRASE))
  # logger.info("Found #{database.routes.size} routes.")
  database = Database::Sniffer.new(URL, PASSPHRASE)
  puts database.routes.inspect

  # logger.info("Will post the routes now...")
  # Transmitter.transmit_all(database.routes)
  # logger.info("successfully posted")
end

main
