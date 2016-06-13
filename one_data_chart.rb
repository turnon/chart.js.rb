require 'multi_data_chart'
require 'js'

class OneDataChart

  include Js

  def initialize opts={}, &blk
    @objs = opts[:data]
    @by = blk
  end

  def labels
    groups.keys
  end

  def datasets
    [
      {
        label: @name,
        data: groups.values.map{ |group| group.count }
      }
    ]
  end

  def group_by attr=nil, &blk
    MultiDataChart.new base: groups, attr: attr, &blk
  end

  private

  def groups
    @groups ||= @objs.group_by &@by
  end
end