require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestPie < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"pie"."data":/, json
  end

  def setup
    MyChartType.load_concrete_charts
    @ch = MyChartType::Pie.new mock_xy
  end
end
