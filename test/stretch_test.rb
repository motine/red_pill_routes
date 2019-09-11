require_relative 'test_helper'

describe Stretch do
  describe "constructor" do
    it "can be instantiated and retains metadata" do
      s = Stretch.new('someid', 'a', 'b', {meta: 'data'})
      s.route_id.must_equal 'someid'
      s.start_node.must_equal 'a'
      s.end_node.must_equal 'b'
      s.metadata.must_equal({meta: 'data'})
    end
  end

  describe "order" do
    it "fails if there are multiple possibilities" do
      assert_raises {
        Stretch.order([Stretch.new('1', 'a', 'b'), Stretch.new('1', 'a', 'c')])
      } 
    end

    it "fails if there is no start" do
      assert_raises { Stretch.order([]) }
    end

    it "orders correctly" do
      sorted = Stretch.order([Stretch.new('1', 'b', 'c'), Stretch.new('1', 'a', 'b'), Stretch.new('1', 'c', 'd')])
      sorted.must_equal([Stretch.new('1', 'a', 'b'), Stretch.new('1', 'b', 'c'), Stretch.new('1', 'c', 'd')])
    end
  end
end
