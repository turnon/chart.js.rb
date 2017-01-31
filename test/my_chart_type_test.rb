require 'minitest/autorun'
require 'chart/my_chart_type'

class TestMyChartType < MiniTest::Unit::TestCase

  def test_find_definitions
    dfs = MyChartType.send(:definitions)
    act_files = Dir[File.expand_path('../../lib/charts/*', __FILE__)]
    assert_equal Set.new(dfs), Set.new(act_files)
  end

  def test_auto_load_default_charts
    act = Set.new MyChartType.to_a
    exp = Set.new %w[Line Bar PlainBar Pie Radar Doughnut PolarArea].map{|k| MyChartType.const_get(k)}
    assert_equal exp, act
  end

  def test_auto_load_default_charts_cmd
    exp = Set.new
    MyChartType.each_sym do |sym|
      exp << sym
    end
    act = Set.new([:line, :bar, :plainBar, :pie, :radar, :doughnut, :polarArea])
    assert_equal exp, act
  end

  def test_undefined_chart_type
    ex = assert_raises(Exception) do
      MyChartType.concrete :asdfgh
    end
    assert_equal 'no such chart: asdfgh', ex.message
  end

  def setup
    MyChartType.load_concrete_charts
  end
end
