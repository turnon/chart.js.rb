require 'minitest/autorun'
require 'xyz'

class TestXYZ < MiniTest::Unit::TestCase

  def test_labels
    assert_equal [0,1,2], @xyz.labels
  end

  def test_datasets
    exp = [{label: 'even', data: [3,3,4]},{label: 'odd', data: [3,4,3]}]
    assert_equal exp, @xyz.datasets
  end

  def setup
    @xyz = XYZ.new({0 => {'odd' => [3,9,15], 'even' => [6,12,18]} ,
           1 => {'odd' => [1,7,13,19], 'even' => [4,10,16]},
           2 => {'odd' => [5,11,17], 'even' => [2,8,14,20]}})
  end
end
