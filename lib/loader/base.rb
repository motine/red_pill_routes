# frozen_string_literal: true

module Loader
  # Base class for all loaders.
  # Loaders can retrieve a number of files from a source.
  # The receive method must be overridden in the deriving classes.
  # It is supposed to return a hash mapping a file's name to file's contents.
  class Base
    def retrieve(_source)
      raise 'implement me in subclass!'
    end
  end
end
