task :test do
  TEST_DIR = File.join(__dir__, 'test')
  Dir.glob('**/*_test.rb', base: TEST_DIR).each do |path|
    require_relative File.absolute_path(path, TEST_DIR)
  end
end