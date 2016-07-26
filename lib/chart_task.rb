require 'ostruct'
require 'chart/my_chart_type'

class ChartTask

  attr_reader :para

  def initialize para
    @para = OpenStruct.new para
  end

  def build
    MyChartType.concrete self
  end
  
  def data
    data_task.result
  end
  
  def id
    [type, data_task.id].join('_').to_sym
  end

  def type_class
    type.capitalize
  end

  def method_missing name, *args, &blk
    para.respond_to?(name) ? para.send(name) : nil    
  end

end
