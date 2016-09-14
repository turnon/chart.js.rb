require 'xy'

class X
  def initialize objs
    @objs = objs
  end

  def select &blk
    X.new value.select(&blk)
  end

  def group_by &blk
    XY.new value.group_by(&blk)
  end

  def value
    @objs
  end

  def == obj
    obj.kind_of? X and value == obj.value
  end

end
