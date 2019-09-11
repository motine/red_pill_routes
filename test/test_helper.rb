# frozen_string_literal: true

require_relative '../lib/lib'

require 'minitest/autorun'
require 'minitest/rg'

def content_from_fixture(foldername)
  folder_path = File.join(__dir__, 'fixtures', foldername)
  contents = {}
  Dir.glob('*.*', base: folder_path).each do |filename|
    path = File.absolute_path(File.join(folder_path, filename))
    contents[filename] = File.read(path)
  end
  contents
end
