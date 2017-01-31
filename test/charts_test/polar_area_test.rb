require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestPolarArea < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"polarArea"."data":/, json
  end

  def test_no_z_axis
    ex = assert_raises(Exception) do
      MyChart::Type::PolarArea.new mock_xyz
    end
    assert_equal 'polarArea has no z axis', ex.message
  end

  def setup
    MyChart::Type.load_concrete_charts
    @ch = MyChart::Type::PolarArea.new mock_xy
  end
end
