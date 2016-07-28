require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestLine < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"line"."data":/, json
  end

  def setup
    MyChartType.load
    @ch = MyChartType::Line.new mock_data_xyz
  end
end
