# frozen_string_literal: true

require 'zip'

module Loader
  # Unpacks a zip from a given URL using the given passphrase.
  # source (see retrieve) is used to send to as query string when making the request.
  class ZipFromUrl
    def initialize(url, passphrase)
      @url = url
      @passphrase = passphrase
    end

    def retrieve(source)
      response = HTTParty.get(@url, query: { 'passphrase' => @passphrase, 'source' => source })

      contents = {}
      Zip::File.open_buffer(response.body) do |zip_file| # stolen here: https://stackoverflow.com/a/43748729/4007237
        zip_file.each do |entry|
          next if entry.ftype != :file || entry.name.include?('__MACOSX')

          filename = File.basename(entry.name)
          content = entry.get_input_stream.read
          contents[filename] = content
        end
      end
      contents
    end
  end
end
