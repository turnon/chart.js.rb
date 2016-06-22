require 'tasks'
require 'x'
require 'erb'

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
  AND = :_and_
  OF = :_of_

  class Chart

    def initialize
      @tasks = Tasks.new
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
    end

    def generate
      @tasks.exe
    end

    def value name
      @tasks[name.to_sym].result.value
    end

    class GroupByARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if args.size == 2 and args[1].kind_of? Hash and args[1][:by]
          @material_id = args[0]
          @production_id = [args[1][:by], OF, @material_id].join.to_sym
        elsif args.size == 1 and args[0].kind_of? Hash and args[0][:by]
          @material_id = ALL_DATA
          @production_id = args[0][:by]
        else
          raise "invalid arguments for group_by : #{args}"
        end
      end
    end

    class SelectFromARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if args.size == 2 and args[1].kind_of? Hash and args[1][:from]
          @material_id = args[1][:from]
          @production_id = [args[0], AND, material_id].join.to_sym
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