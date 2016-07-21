require 'minitest/autorun'
require 'chart_task'
require 'charts/bar'
require 'xy'
require 'mock_data'

class TestChartTask < MiniTest::Unit::TestCase

  def test_interface
    assert_includes ChartTask.instance_methods, :build
    assert_kind_of Bar, @chart_task.build
  end

  def setup
    task = {type: :bar, data_task: mock_data_task_xy}
    @chart_task = ChartTask.new task
  end  

end