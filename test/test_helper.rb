# frozen_string_literal: true

require_relative '../lib/lib'

require 'minitest/autorun'
require 'minitest/rg'

def fixture_base_path
  File.join(__dir__, 'fixtures')
end
