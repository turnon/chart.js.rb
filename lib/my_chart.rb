require 'material_pool'
require 'raw_data'
require 'erb'

module MyChart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart.write
    end

  end

  class Chart

    def initialize
      @materials = MaterialPool.new
    end

    def data dat=nil, &blk
      put :__all__, RawData.new(dat.nil? ? blk.call : dat)
    end

    def select name, &blk
      put name, all_data.select(&blk)
    end

    def group_by name, opts={}, &blk    
      material = opts[:base_on] ? get(opts[:base_on]) : all_data
      by = block_given? ? blk : name.to_sym
      put name.to_sym, material.group_by(opts.merge({name: name.to_sym}), &by)
    end

    def output file
      @file = file
    end

    def write
      canvases = @materials.productions
      html = ERB.new(File.read html_template).result(binding)
      File.write @file, html
    end

    private

    def get name
      @materials.get name.to_sym
    end

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