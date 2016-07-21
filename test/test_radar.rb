require 'minitest/autorun'
require 'charts/radar'

class TestRadar < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"radar"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :radar
  end

  def setup
    mod5 = XYZ.new({
           0 => {'even' => [10], 'odd' => [5,15]},
           1 => {'even' => [6,16], 'odd' => [1,11,91]},
           2 => {'even' => [2,12,92], 'odd' => [7,17]},
           3 => {'even' => [8,18], 'odd' => [3,13,93]},
           4 => {'even' => [4,14,94], 'odd' => [9,19]}
           })
    @ch = Radar.new data: mod5
  end
end