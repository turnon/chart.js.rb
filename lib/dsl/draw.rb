require 'chart/proto'
require 'chart_task'

module MyChart
  class Chart

    Proto.derive.each do |chart_cmd|
      define_method chart_cmd do |opts={}, &group_cmd|
        task = {type: chart_cmd, data_task: group_cmd.call}.merge opts
        chart_task = ChartTask.new task
        chart_constructors << chart_task
      end
    end

  end
end
