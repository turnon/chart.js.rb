module XY

  def initialize opts={}, &blk
    @objs = opts[:data]
    @by = blk
    acceptStyle opts
  end
  
  private
  
  def type
    self.class.to_s.downcase
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