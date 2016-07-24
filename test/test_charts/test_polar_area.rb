require 'minitest/autorun'
require 'chart/my_chart_type'
require 'mock_data'

class TestPolarArea < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"polarArea"."data":/, json
  end

  def test_no_z_axis
    ex = assert_raises(Exception) do
      MyChartType::PolarArea.new mock_data_xyz
    end
    assert_equal 'polarArea has no z axis', ex.message
  end

  def setup
    MyChartType.load
    @ch = MyChartType::PolarArea.new mock_data_xy
  end
end
