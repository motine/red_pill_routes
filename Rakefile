task :test do
  test_folder_path = File.join(__dir__, 'test')
  Dir.glob('**/*_test.rb', base: test_folder_path).each do |path|
    require_relative File.absolute_path(path, test_folder_path)
  end
end