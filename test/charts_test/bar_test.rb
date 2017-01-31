require 'minitest/autorun'
require 'my_chart/type'
require 'mock_data'

class TestBar < MiniTest::Unit::TestCase

  def test_tojs
    json = @bar.json
    assert_match /"type":"bar"."data":/, json
  end

  def setup
    MyChart::Type.load_concrete_charts
    @bar = MyChart::Type::Bar.new mock_xy
  end
end
