require 'tasks'
require 'x'
require 'erb'
require 'chart/proto'

module MyChart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart.generate
      @chart#.write
    end

  end

  ALL_DATA = Tasks::ROOT

  class Chart

    Proto.derive.each do |c|
      define_method c do |&group|
        @chart_type_and_id_s << [c, group.call]
      end
    end

    def initialize
      @tasks = Tasks.new
      @chart_type_and_id_s = []
    end

    def material dat=nil, &blk
      @tasks.add ALL_DATA do |pre|
        objs = dat.nil? ? blk.call : dat
        X.new(objs)
      end
    end

    def select *args, &blk
      arg = SelectFromARGV.new *args
      @tasks.add arg.production_id, depends_on: arg.material_id do |pre|
        pre.select &blk
      end
    end

    def group *args, &blk
      arg = GroupByARGV.new *args
      @tasks.add arg.production_id, depends_on: arg.material_id do |pre|
        pre.group_by &blk
      end
      arg.production_id
    end

    attr_reader :charts

    def generate
      @tasks.exe
      @charts = @chart_type_and_id_s.map{|i| Proto.concrete i[0],i[1] }
    end

    def value name
      @tasks[name.to_sym].result.value
    end

    class GroupByARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if specified_material? args
          @material_id = args[0]
          @production_id = concat_production_id @material_id, args[1][:by]
        elsif not_specified_material? args
          @material_id = ALL_DATA
          @production_id = [:GROUP, :BY, args[0][:by]].join('_').to_sym
        else
          raise "invalid arguments for group_by : #{args}"
        end
      end

      private

      def specified_material? args
        args.size == 2 and args[1].kind_of? Hash and args[1][:by]
      end

      def not_specified_material? args
        args.size == 1 and args[0].kind_of? Hash and args[0][:by]
      end

      def concat_production_id material, by
        string = if material =~ /^GROUP/
                   [material, :AND_THEN, :GROUP, :BY, by]
                 else
                   [:GROUP, material, :BY, by]
                 end
        string.join('_').to_sym
      end
    end

    class SelectFromARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if args.size == 2 and args[1].kind_of? Hash and args[1][:from]
          @material_id = args[1][:from]
          @production_id = [args[0], :FROM, material_id].join('_').to_sym
        elsif args.size == 1
          @material_id = ALL_DATA
          @production_id = args[0]
        else
          raise "invalid arguments for select : #{args}"
        end
      end
    end

    private

    def html_template
      File.join File.dirname(__FILE__), 'tmpl.htm'
    end

  end

end
