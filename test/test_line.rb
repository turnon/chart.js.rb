require 'minitest/autorun'
require 'charts/line'

class TestLine < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"line"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :line
  end

  def setup
    xyz = XYZ.new({0 => {'even' => [6,12,18], 'odd' => [3,9,15]},
           1 => {'even' => [4,10,16], 'odd' => [1,7,13,19]},
           2 => {'even' => [2,8,14,20], 'odd' => [5,11,17]}})
    @ch = Line.new data: xyz
  end
end