require 'tasks'
require 'x'
require 'dsl/my_chart_group_by_argv'
require 'dsl/my_chart_select_from_argv'
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

    Proto.derive.each do |chart_cmd|
      define_method chart_cmd do |&group_cmd|
        @chart_type_and_id_s << [chart_cmd, group_cmd.call]
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
      @charts = @chart_type_and_id_s.map{|type_and_id| Proto.concrete *type_and_id }
    end

    def value name
      @tasks[name.to_sym].result.value
    end

    private

    def html_template
      File.join File.dirname(__FILE__), 'tmpl.htm'
    end

  end

end
