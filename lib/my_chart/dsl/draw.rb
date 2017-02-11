require 'my_chart/type'

module MyChart
  module Dsl
    module Draw

      MyChart::Type.each_sym do |chart_cmd|

        define_method chart_cmd do |*arg|
          chart_config = ChartCmdARGV.new *arg

          chart_id = "#{chart_cmd}__#{chart_config.data_id}".to_sym
          klass = MyChart::Type.concrete chart_cmd
          grp_data = grouped chart_config

          charts[chart_id] = klass.new grp_data, id: chart_id, w: chart_config.w, h: chart_config.h, name: chart_config.name
        end
      end

      def charts
        @charts ||= {}
      end

      def grouped cfg = nil
        @grouped ||= {}

        return @grouped unless cfg

        x = get_x cfg.from
        grp_m = check_overwrite_group_method cfg.x
        xy = (@grouped[[cfg.x, cfg.from]] ||= (x.group_by &grp_m))
        xy = (@grouped[[cfg.x, cfg.keys, cfg.from]] ||= (xy.complete_keys cfg.keys)) if cfg.keys
        xy = xy.sort(cfg) if cfg.asc or cfg.desc
        xy = xy.limit(cfg) if cfg.first or cfg.last
        return xy unless cfg.y

        grp_m = check_overwrite_group_method cfg.y
        @grouped[[cfg.x, cfg.y, cfg.keys, cfg.from]] ||= xy.group_by(&grp_m)
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

        def method_missing name, *arg
          return opt[name] if [:w, :h, :name, :from, :keys, :asc, :desc, :first, :last].include? name
          super
        end

        def sort
          order = (asc and :asc) or (desc and :desc)
          [order, 'by', (asc or desc)].join('_') if order
        end

        def limit
          lm = (first and :first) or (last and :last)
          [lm, (first or last)].join('_') if lm
        end

        def data_id
          [x,
           y ? y : "no_y",
           keys ? "keys_#{keys.hash}" : "no_keys",
           from ? "from_#{from}" : "from_all",
           sort,
           limit
          ].compact.join '__'
        end
      end

    end
  end
end
