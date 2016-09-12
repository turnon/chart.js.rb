require 'chart/my_chart_type'
require 'chart_task'
require 'xy'

module MyChart
  class Chart

    MyChartType.each_sym do |chart_cmd|
      #define_method "complex_#{chart_cmd}" do |opts={}, &group_cmd|
      #  task = {type: chart_cmd, data_task: group_cmd.call}.merge opts
      #  chart_task = ChartTask.new task
      #  chart_constructors << chart_task
      #end

      define_method chart_cmd do |*arg|
	chart_config = ChartCmdARGV.new *arg
	grp = @__data__.group_by &chart_config.x
	xy = XY.new grp
        grouped[chart_config.data_id] = xy
	klass = MyChartType.concrete chart_cmd
	charts["#{chart_cmd}__#{chart_config.data_id}".to_sym] = klass.new xy
      end
    end

    class ChartCmdARGV

      attr_reader :opt, :x, :y

      def initialize *arg
	return if arg.empty?
        @opt = arg[-1] if arg[-1].kind_of? Hash
	@x = arg[0] if arg[0].kind_of? Symbol
	@y = arg[1] if arg[1] and arg[1].kind_of? Symbol
      end

      def data_id
	(y ? "#{x}__#{y}" : "#{x}").to_sym
      end
    end

  end
end
