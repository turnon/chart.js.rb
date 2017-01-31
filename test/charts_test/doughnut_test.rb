require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestDoughnut < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"doughnut"."data":/, json
  end

  def setup
    MyChart::Type.load_concrete_charts
    @ch = MyChart::Type::Doughnut.new mock_xy
  end
end
