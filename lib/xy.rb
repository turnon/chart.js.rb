require 'xyz'

class XY
  def initialize objs_hash
    @objs_hash = objs_hash
  end

  def select &blk
    XY.new value.select(&blk)
  end

  def group_by &blk
    XYZ.new Hash[value.map{ |group_name, objs| [group_name, objs.group_by(&blk)] }]
  end

  def value
    @objs_hash
  end

  def labels
    value.keys
  end

  def datasets
    [{label: 'xy', data: value.values.map{|objs| objs.count}}]
  end

  def == obj
    obj.kind_of? XY and value == obj.value
  end

  def complete_keys range=nil
    return self unless range
    new_hash = value.dup
    range.each do |key|
      new_hash[key] = [] unless new_hash[key]
    end
    XY.new new_hash
  end

end
