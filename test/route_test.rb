require_relative 'test_helper'

describe Route do
  describe "constructor" do
    it "can be instantiated" do
      start_time = Time.now
      end_time = Time.now
      r = Route.new('a', 'b', start_time, end_time, 'yeeey')
      r.start_node.must_equal 'a'
      r.end_node.must_equal 'b'
      r.start_time.must_equal start_time
      r.end_time.must_equal end_time
      r.source.must_equal 'yeeey'
    end
  end
end
