#!/usr/bin/env ruby

require_relative 'lib/lib'

URL = 'https://challenge.distribusion.com/the_one/routes'
PASSPHRASE = 'Kans4s-i$-g01ng-by3-bye'
DATABASES_TO_INSTANCIATE = [Database::Loophole, Database::Sentinel, Database::Sniffer]

def create_database(logger)
  logger.info("Reading data from files")
  database_instances = DATABASES_TO_INSTANCIATE.collect { |klass| klass.new(URL, PASSPHRASE) }
  database = Database::Aggregator.new(database_instances)
  logger.info("Found #{database.routes.size} routes.")
  database
end

def transmit_database(database, logger)
  logger.info("Will post the routes now...")
  transmitter = Transmitter.new(URL, PASSPHRASE)
  transmitter.transmit_all(database.routes)
  logger.info("successfully posted")
end

def main
  logger = Logger.new(STDOUT)
  database = create_database(logger)
  transmit_database(database, logger)
end

main
