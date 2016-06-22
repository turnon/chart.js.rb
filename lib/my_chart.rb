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

    def select name, opt={}, &blk
      if opt[:from]
        material_id = opt[:from]
        production_id = [name, AND, material_id].join.to_sym
      else
        material_id = ALL_DATA
        production_id = name
      end
      @tasks.add production_id, depends_on: material_id do |pre|
        pre.select &blk
      end
    end

    def generate
      @tasks.exe
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