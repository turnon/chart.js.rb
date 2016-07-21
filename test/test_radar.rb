require 'minitest/autorun'
require 'charts/radar'
require 'mock_data'

class TestRadar < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"radar"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :radar
  end

  def setup
    @ch = Radar.new mock_data_xyz
  end
end