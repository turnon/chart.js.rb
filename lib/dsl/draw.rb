require 'chart/my_chart_type'

module MyChart
  class Chart

    MyChartType.each_sym do |chart_cmd|

      define_method chart_cmd do |*arg|
	chart_config = ChartCmdARGV.new *arg

	chart_id = "#{chart_cmd}__#{chart_config.data_id}".to_sym
	klass = MyChartType.concrete chart_cmd
	grp_data = grouped chart_config

	charts[chart_id] = klass.new grp_data, id: chart_id, w: chart_config.w, h: chart_config.h
      end
    end

    def charts
      @charts ||= {}
    end

    def grouped chart_config = nil
      @grouped ||= {}

      return @grouped unless chart_config

      x = get_x chart_config.from
      grp_m = check_overwrite_group_method chart_config.x
      xy = (@grouped[chart_config.xy_id] ||= (x.group_by &grp_m))
      return xy unless chart_config.y

      grp_m = check_overwrite_group_method chart_config.y
      @grouped[chart_config.xyz_id] ||= xy.group_by(&grp_m)
    end

    def check_overwrite_group_method method_id
      group_by_methods[method_id] || method_id
    end

    class ChartCmdARGV

      attr_reader :opt, :x, :y

      def initialize *arg
	return if arg.empty?
        @opt = (arg[-1].kind_of? Hash) ? arg[-1] : {}
	@x = arg[0] if arg[0].kind_of? Symbol
	@y = arg[1] if arg[1] and arg[1].kind_of? Symbol
      end

      def w
	opt[:w]
      end

      def h
	opt[:h]
      end

      def from
	opt[:from]
      end

      def xy_id
	(from ? "#{x}__from__#{from}" : x).to_sym
      end

      def xyz_id
	(from ? "#{x}__#{y}__from__#{from}" : "#{x}__#{y}").to_sym
      end

      def data_id
	y ? xyz_id : xy_id
      end
    end

  end
end
