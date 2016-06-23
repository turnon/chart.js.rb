class XYZ
  def initialize objs_2d_hash
    @objs_2d_hash = objs_2d_hash
  end

  #def select &blk
  #  XY.new value.select(&blk)
  #end

  #def group_by &blk
  #  XY.new value.group_by(&blk)
  #end

  def value
    @objs_2d_hash
  end

end