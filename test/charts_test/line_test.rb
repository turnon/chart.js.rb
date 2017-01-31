require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestLine < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"line"."data":/, json
  end

  def setup
    MyChart::Type.load_concrete_charts
    @ch = MyChart::Type::Line.new mock_xyz
  end
end
