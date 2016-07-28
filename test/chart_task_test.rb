require 'minitest/autorun'
require 'chart_task'
require 'chart/my_chart_type'
require 'xy'
require 'mock_data'

class TestChartTask < MiniTest::Unit::TestCase

  def test_interface
    assert_includes ChartTask.instance_methods, :build
    assert_kind_of MyChartType::Bar, @chart_task.build
  end

  def setup
    MyChartType.load
    task = {type: :bar, data_task: mock_data_task_xy}
    @chart_task = ChartTask.new task
  end  

end
