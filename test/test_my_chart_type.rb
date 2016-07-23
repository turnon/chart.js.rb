require 'minitest/autorun'
require 'chart/my_chart_type'

class TestMyChartType < MiniTest::Unit::TestCase

  def test_auto_load_default_charts
    concretes = []
    MyChartType.each_sym{|sym| concretes << sym}
    assert_includes concretes, :line
    assert_includes concretes, :bar
    assert_includes concretes, :pie
    assert_includes concretes, :radar
    assert_includes concretes, :doughnut
    assert_includes concretes, :polarArea
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
