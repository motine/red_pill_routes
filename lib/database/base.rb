# frozen_string_literal: true

module Database
  # (Abstract) base class for all databases.
  #
  # The @contents member contains a hash mapping a filename to its contents.
  #
  # Contract:
  # The constructor will call retreive_contents and and parse_routes.
  # Both `source` and `parse_routes` must be overridden in deriving classes.
  class Base
    attr_reader :routes

    def initialize(loader)
      @contents = loader.retrieve(source)
      parse_routes
    end

    # Determines the name of the source.
    def source
      raise 'implement me!'
    end

    protected

    # Reads the data from the files and sets @routes. Must be overridden in the concrete classes.
    def parse_routes
      raise 'implement me!'
    end

    # Reads the json from the filename's contents and returns a list of OpenStructs.
    # Assumes that the JSON in contents contains a hash with a single key that maps to a list.
    def json_array(filename)
      json_content(filename).first[1].collect do |row|
        OpenStruct.new(row)
      end
    end

    def json_content(filename)
      JSON.parse(@contents[filename])
    end

    # Parses the filename's contents CSV and returns a list of OpenStructs
    def csv_content(filename)
      CSV.parse(@contents[filename].force_encoding('UTF-8'), headers: true, quote_char: '"', col_sep: ', ').collect do |row|
        OpenStruct.new(row.to_h)
      end
    end
  end
end
