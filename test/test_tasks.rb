require 'minitest/autorun'
require 'tasks'

class TestTasks < MiniTest::Unit::TestCase

  def test_execute_after_dependencies
    assert_equal ['d', 'b', 'a', 'c', 'e'], @process
    dep = {a: :b, b: :d, c: :a, e: :d}
    assert_equal dep, @dep
  end

  def test_remain_ordered
    assert_equal [:a, :b, :c, Tasks::ROOT, :e], @tasks.order
  end

  def setup
    @tasks = Tasks.new

    @process = []
    @dep = {}

    @tasks.add :a, depends_on: :b do |pre|
      @process << 'a'
      @dep[:a] = pre
      :a
    end

    @tasks.add :b do |pre|
      @process << 'b'
      @dep[:b] = pre
      :b
    end

    @tasks.add :c, depends_on: :a do |pre|
      @process << 'c'
      @dep[:c] = pre
      :c
    end

    @tasks.add do
      @process << 'd'
      :d
    end

    @tasks.add :e do |pre|
      @process << 'e'
      @dep[:e] = pre
      :e
    end

    @tasks.exe
  end
end