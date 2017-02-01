require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestRadar < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"radar"."data":/, json
  end

  def setup
    MyChart::Type.load_concrete_charts
    @ch = MyChart::Type::Radar.new mock_xyz
  end
end
