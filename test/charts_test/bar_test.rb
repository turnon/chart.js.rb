require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestBar < MiniTest::Unit::TestCase

  def test_tojs    
    json = @bar.json
    assert_match /"type":"bar"."data":/, json
  end

  def setup
    MyChartType.load_concrete_charts
    @bar = MyChartType::Bar.new mock_xy
  end
end
