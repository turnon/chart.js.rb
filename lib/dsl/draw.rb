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

	chart_id = "#{chart_cmd}__#{chart_config.data_id}".to_sym
	klass = MyChartType.concrete chart_cmd
	grp_data = grouped chart_config

	charts[chart_id] = klass.new grp_data
      end
    end

    def charts
      @charts ||= {}
    end

    def grouped chart_config = nil
      @grouped ||= {}
      return @grouped unless chart_config
      grp_m = check_overwrite_group_method chart_config.x
      xy = (@grouped[chart_config.xy_id] ||= XY.new(@__data__.group_by &grp_m))
      unless chart_config.y
        xy
      else
        grp_m = check_overwrite_group_method chart_config.y
        @grouped[chart_config.xyz_id] ||= xy.group_by(&grp_m)
      end
    end

    def check_overwrite_group_method method_id
      group_by_methods[method_id] || method_id
    end

    class ChartCmdARGV

      attr_reader :opt, :x, :y

      def initialize *arg
	return if arg.empty?
        @opt = arg[-1] if arg[-1].kind_of? Hash
	@x = arg[0] if arg[0].kind_of? Symbol
	@y = arg[1] if arg[1] and arg[1].kind_of? Symbol
      end

      def from
	opt[:from] if opt
      end

      def xy_id
	x.to_sym
      end

      def xyz_id
	"#{x}__#{y}".to_sym
      end

      def data_id
	y ? xyz_id : xy_id
      end
    end

  end
end
