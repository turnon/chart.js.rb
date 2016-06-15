require 'chart/proto'
require 'helper/symbol'

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
    require "charts/#{type.underscore}"
    raise "can not find chart type #{type} in #{Proto.list}" if Proto[type].nil?
    Proto[type]
  end

end