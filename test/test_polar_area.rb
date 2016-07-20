require 'minitest/autorun'
require 'charts/polar_area'

class TestPolarArea < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"polarArea"."data":/, json
  end

  def test_derive
    assert_includes Proto.derive, :polarArea
  end

  def test_no_z_axis
    xyz = XYZ.new({0 => {'even' => [6,12,18], 'odd' => [3,9,15]},
           1 => {'even' => [4,10,16], 'odd' => [1,7,13,19]},
           2 => {'even' => [2,8,14,20], 'odd' => [5,11,17]}})
    ex = assert_raises(Exception) do
      PolarArea.new xyz
    end
    assert_equal 'polarArea has no z axis', ex.message
  end

  def setup
    xy = XY.new({:a => [1,2,3,4,5,6], :b => [1,2,3], :c => [1,2,3,4], :d => [1], :f => [1,2]})
    @ch = PolarArea.new xy
  end
end
