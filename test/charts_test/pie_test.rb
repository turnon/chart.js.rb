require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestPie < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"pie"."data":/, json
  end

  def setup
    MyChart::Type.load_concrete_charts
    @ch = MyChart::Type::Pie.new mock_xy
  end
end
