require 'minitest/autorun'
require 'my_chart/type'

class TestMyChartType < MiniTest::Unit::TestCase

  def test_find_definitions
    dfs = MyChart::Type.send(:definitions)
    act_files = Dir[File.expand_path('../../lib/my_chart/charts/*', __FILE__)]
    assert_equal Set.new(dfs), Set.new(act_files)
  end

  def test_auto_load_default_charts
    act = Set.new MyChart::Type.to_a
    exp = Set.new %w[Line Bar PlainBar Pie Radar Doughnut PolarArea].map{|k| MyChart::Type.const_get(k)}
    assert_equal exp, act
  end

  def test_auto_load_default_charts_cmd
    exp = Set.new
    MyChart::Type.each_sym do |sym|
      exp << sym
    end
    act = Set.new([:line, :bar, :plainBar, :pie, :radar, :doughnut, :polarArea])
    assert_equal exp, act
  end

  def test_undefined_chart_type
    ex = assert_raises(Exception) do
      MyChart::Type.concrete :asdfgh
    end
    assert_equal 'no such chart: asdfgh', ex.message
  end

  def setup
    MyChart::Type.load_concrete_charts
  end
end
