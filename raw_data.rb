require 'chart/js'
require 'chart/xy'
require 'chart/z'

class RawData
  def initialize objs
    @objs = objs
  end

  def select &blk
    RawData.new @objs.select(&blk)
  end

  def group_by opts={}, &blk
    type = getChartType(opts[:type])
    type.new opts.merge({data: @objs}), &blk
  end

  private

  def getChartType type
    require "charts/#{type.to_s}"
    Module.const_get type.capitalize
  end

end