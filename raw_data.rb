require 'one_data_chart'

class RawData
  def initialize objs
    @objs = objs
  end

  def select &blk
    RawData.new @objs.select(&blk)
  end

  def group_by &blk
    OneDataChart.new data: @objs, &blk
  end

end