# frozen_string_literal: true

require_relative 'test_helper'

require 'ostruct'

describe Loader::ZipFromUrl do
  describe 'retrieve' do
    it 'retrieves a zip and unpacks it' do
      response = OpenStruct.new(body: File.read(File.join(__dir__, 'fixtures', 'test.zip')))
      HTTParty.stub(:get, response) do
        loader = Loader::ZipFromUrl.new('', '')
        contents = loader.retrieve('mysource')

        contents.keys.sort.must_equal ['a.txt', 'b.txt']
        contents['a.txt'].must_equal 'A'
        contents['b.txt'].must_equal 'B'
      end
    end

    # more tests could be
    # 'raises when receiving bad response'
    # 'raises when receiving invalid zip'
  end
end
