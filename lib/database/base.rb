require 'zip'

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

    def initialize(url=nil, passphrase=nil)
      @url = url
      @passphrase = passphrase
      retrieve_contents
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

    # Calls the endpoint and unpacks the zip info @contents.
    def retrieve_contents
      response = HTTParty.get(@url, query: { 'passphrase' => @passphrase, 'source' => source })

      @contents = {}
      Zip::File.open_buffer(response.body) do |zip_file| # stolen here: https://stackoverflow.com/a/43748729/4007237
        # Handle entries one by one
        zip_file.each do |entry|
          next if entry.ftype != :file || entry.name.include?('__MACOSX')
          filename = File.basename(entry.name)
          content = entry.get_input_stream.read
          @contents[filename] = content
        end
      end
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
