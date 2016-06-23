require 'minitest/autorun'
require 'x'
require 'xy'
require 'xyz'

class TestXYZ < MiniTest::Unit::TestCase

  def test_xy
    assert_equal ({'even' => [2,4,6,8,10], 'odd' => [1,3,5,7,9]}), @xy.value
  end

  def test_xyz
    exp = {'even' => {'divisible_by_3' => [6], 'not_divisible_by_3' => [2,4,8,10]},
           'odd' => {'divisible_by_3' => [3,9], 'not_divisible_by_3' => [1,5,7]}}
    assert_equal exp, @xyz.value
  end

  def setup
    @x = X.new (1..10).to_a
    @xy = @x.group_by {|num| num.even? ? 'even' : 'odd'}
    @xyz = @xy.group_by {|num| (num % 3 == 0) ? 'divisible_by_3' : 'not_divisible_by_3'}
  end
end