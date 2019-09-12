#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/lib'

URL = 'https://challenge.distribusion.com/the_one/routes'
PASSPHRASE = 'Kans4s-i$-g01ng-by3-bye'
DATABASES_TO_USE = [Database::Loophole, Database::Sentinel, Database::Sniffer].freeze

def create_database
  loader = Loader::ZipFromUrl.new(URL, PASSPHRASE)
  database_instances = DATABASES_TO_USE.collect { |klass| klass.new(loader) }
  Database::Aggregator.new(database_instances)
end

def transmit_database(database)
  transmitter = Transmitter.new(URL, PASSPHRASE)
  transmitter.transmit_all(database.routes)
end

def main
  logger = Logger.new(STDOUT)
  logger.info('Reading data from files')
  database = create_database
  logger.info("Found #{database.routes.size} routes.")

  logger.info('Will post the routes now...')
  transmit_database(database)
  logger.info('successfully posted')
end

main
