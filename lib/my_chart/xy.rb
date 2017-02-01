require 'my_chart/xyz'

module MyChart
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

    def sort order
      compare = if :key === order.asc
                  -> a, b { a[0] <=> b[0] }
  	        elsif :key === order.desc
                  -> a, b { b[0] <=> a[0] }
  	        elsif :count === order.asc
                  -> a, b { a[1].size <=> b[1].size }
  	        else
                  -> a, b { b[1].size <=> a[1].size }
  	        end
      sorted = value.to_a.sort &compare
      new_hash = Hash[sorted]
      XY.new new_hash
    end

    def limit config
      limit_method, num = config.first ? [:first, config.first] : [:last, config.last]
      limited = value.to_a.send limit_method, num
      new_hash = Hash[limited]
      XY.new new_hash
    end

  end
end
