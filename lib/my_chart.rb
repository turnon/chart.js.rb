require 'material_pool'
require 'x'
require 'erb'

module MyChart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart#.write
    end

  end

  ALL_DATA = :__all__
  AND = :_and_

  class Chart

    def initialize
      @materials = MaterialPool.new
    end

    def material dat=nil, &blk
      objs = dat.nil? ? blk.call : dat
      put ALL_DATA, X.new(objs)
    end

    def select name, opt={}, &blk
      if opt[:from]
        material_id = opt[:from]
        production_id = [name, AND, material_id].join.to_sym
      else
        material_id = ALL_DATA
        production_id = name
      end
      put production_id, get(material_id).select(&blk)
    end

    def get name
      @materials.get name.to_sym
    end

    private

    def put name, material
      @materials.put name.to_sym, material
    end

    def all_data
      get :__all__
    end

    def html_template
      File.join File.dirname(__FILE__), 'tmpl.htm'
    end

  end

end