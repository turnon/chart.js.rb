module XY

  def initialize opts={}, &blk
    @objs = opts[:data]
    @by = blk
    acceptStyle opts
  end
  
  private
  
  def type
    class_name = self.class.to_s
    class_name[0].downcase + class_name[1..-1]
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

  def groups
    @groups ||= @objs.group_by &@by
  end

end