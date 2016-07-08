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

  def setup
    xy = XY.new({:a => [1,2,3,4,5,6], :b => [1,2,3], :c => [1,2,3,4], :d => [1], :f => [1,2]})
    @ch = PolarArea.new xy
  end
end
