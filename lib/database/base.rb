module Database
  # (Abstract) base class for all databases
  # Contract: The constructor will call parse and load the data.
  class Base
    attr_accessor :routes

    def initialize(relative_folder_path)
      @absolute_folder_path = File.absolute_path(File.join(__dir__, '..', '..', relative_folder_path))
      @routes = parse_routes
    end

    protected

    # Reads the data from the files and returns a list of Routes. Must be overridden in the concrete classes.
    def parse_routes
      raise 'implement me!'
    end
  end
end
