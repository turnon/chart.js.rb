require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestBar < MiniTest::Unit::TestCase

  def test_tojs    
    json = @bar.json
    assert_match /"type":"bar"."data":/, json
  end

  def setup
    MyChartType.load
    @bar = MyChartType::Bar.new mock_data_xy
  end
end
