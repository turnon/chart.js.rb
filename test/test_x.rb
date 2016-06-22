require 'minitest/autorun'
require 'x'

class TestX < MiniTest::Unit::TestCase

  def test_transform_to_xy
    xy = @x.group_by {|num| num.even? ? 'even' : 'odd'}
    assert_equal ({'even' => [2,4,6,8,10], 'odd' => [1,3,5,7,9]}), xy.value
  end

  def setup
    @x = X.new (1..10).to_a
  end
end