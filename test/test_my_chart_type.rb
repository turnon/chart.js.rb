require 'minitest/autorun'
require 'chart/my_chart_type'

class TestMyChartType < MiniTest::Unit::TestCase

  def test_find_definitions
    dfs = MyChartType.send(:definitions)
    act_files = Dir[File.expand_path('../../lib/charts/*', __FILE__)]
    assert_equal Set.new(dfs), Set.new(act_files)
  end

  def test_auto_load_default_charts
    concretes = Set.new MyChartType.to_a
    act = Set.new %w[Line Bar Pie Radar Doughnut PolarArea].map{|k| MyChartType.const_get(k)}
    assert_equal concretes, act
  end

  def test_auto_load_default_charts_cmd
    exp = Set.new
    MyChartType.each_sym do |sym|
      exp << sym
    end
    act = Set.new([:line, :bar, :pie, :radar, :doughnut, :polarArea])
    assert_equal exp, act
  end

  def test_undefined_chart_type
    mock_task = MiniTest::Mock.new
    mock_task.expect :type_class, :Asdfgh
    mock_task.expect :type, :asdfgh
    ex = assert_raises(Exception) do
      MyChartType.concrete mock_task
    end
    assert_equal 'no such chart: asdfgh', ex.message
  end

  def setup
    MyChartType.load
  end
end
