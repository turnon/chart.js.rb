require 'minitest/autorun'
require 'xy'

class TestXY < MiniTest::Unit::TestCase

  def test_xy_to_xyz
    xyz = @xy.group_by {|num| num.even? ? 'even' : 'odd'}
    exp = {0 => {'even' => [6,12,18], 'odd' => [3,9,15]},
           1 => {'even' => [4,10,16], 'odd' => [1,7,13,19]},
           2 => {'even' => [2,8,14,20], 'odd' => [5,11,17]}}
    assert_equal exp, xyz.value
  end

  def test_select_x
    only_1_2 = @xy.select {|x| not x.zero?}
    exp = {1 => [1,4,7,10,13,16,19], 2 => [2,5,8,11,14,17,20]}
    assert_equal exp, only_1_2.value
  end

  def test_select_y
    amount_lt_7 = @xy.select {|x, y| y.count < 7 }
    exp = {0 => [3,6,9,12,15,18]}
    assert_equal exp, amount_lt_7.value
  end

  def test_labels
    assert_equal [0,1,2], @xy.labels
  end

  def test_datasets
    assert_equal [6,7,7], @xy.datasets
  end

  def setup
    @xy = XY.new({0 => [3,6,9,12,15,18], 1 => [1,4,7,10,13,16,19], 2 => [2,5,8,11,14,17,20]})
  end
end