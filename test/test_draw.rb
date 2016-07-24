require 'minitest/autorun'
require 'chart/my_chart_type'
require 'my_chart'

class TestDraw < MiniTest::Unit::TestCase
  def test_methods_for_concrete_chart_type
    inst_ms = MyChart::Chart.instance_methods
    assert_includes inst_ms, :line
    assert_includes inst_ms, :bar
    assert_includes inst_ms, :pie
    assert_includes inst_ms, :doughnut
    assert_includes inst_ms, :polarArea
    assert_includes inst_ms, :radar
  end
end
