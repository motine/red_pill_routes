# frozen_string_literal: true

module Loader
  # Loads the files from a folder.
  # source (see retrieve) is used to determine the subfolder underneight base_path.
  class FolderFromDisk
    def initialize(base_path)
      @base_path = base_path
    end

    def retrieve(source)
      folder_path = File.join(@base_path, source)
      contents = {}
      Dir.glob('*.*', base: folder_path).each do |file_name|
        path = File.absolute_path(File.join(folder_path, file_name))
        contents[file_name] = File.read(path)
      end
      contents
    end
  end
end
