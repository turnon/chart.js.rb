require 'pp'

$:.unshift Dir.pwd

require 'material_pool'
require 'raw_data'

module Chart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart.output
    end

  end

  class Chart

    def initialize
      @materials = MaterialPool.new
    end

    def data dat=nil, &blk
      put :all, RawData.new(dat.nil? ? blk.call : dat)
    end

    def select name, &blk
      put name, all_data.select(&blk)
    end

    def group_by name, opts={}, &blk    
      material = opts[:base_on] ? get(opts[:base_on]) : all_data
      by = block_given? ? blk : name.to_sym
      put name.to_sym, material.group_by(&by)
    end

    def output
      pp @materials.production.map{|name, subchart| {name: name, chart: subchart.js}}
    end

    private

    def get name
      @materials.get name.to_sym
    end

    def put name, material
      @materials.put name.to_sym, material
    end

    def all_data
      get :all
    end

  end

end

ARGV.each do |f|
  require File.basename(f, '.rb')
end