require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestDoughnut < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"doughnut"."data":/, json
  end

  def setup
    MyChartType.load_concrete_charts
    @ch = MyChartType::Doughnut.new mock_xy
  end
end
