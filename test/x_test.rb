require 'minitest/autorun'
require 'x'

class TestX < MiniTest::Unit::TestCase

  def test_x_to_xy
    xy = @x.group_by {|num| num % 3}
    exp = {0 => [3,6,9,12,15,18], 1 => [1,4,7,10,13,16,19], 2 => [2,5,8,11,14,17,20]}
    assert_equal exp, xy.value
  end

  def test_select
    gt19 = @x.select {|n| n > 19}
    assert_equal [20], gt19.value
  end

  def setup
    @x = X.new (1..20).to_a
  end
end