class XY
  def initialize objs_hash
    @objs_hash = objs_hash
  end

  def select &blk
    XY.new value.select(&blk)
  end

  #def group_by &blk
  #  XY.new value.group_by(&blk)
  #end

  def value
    @objs_hash
  end

end