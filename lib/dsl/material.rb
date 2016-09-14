require 'x'

module MyChart
  class Chart

    def material dat=nil, &blk
      #@tasks.add ALL_DATA do |pre|
      #  objs = dat.nil? ? blk.call : dat
      #  X.new(objs)
      #end
      @__data__ = (dat ? dat : blk.call)
      raw_data[ALL_DATA] = X.new @__data__
    end

    def select name, opt={}, &blk
      from = opt[:from] || ALL_DATA
      x = raw_data[from]
      raise Exception, '#{from} is not defined' unless x
      result = x.select &blk
      name = opt[:from] ? "#{name}__from__#{opt[:from]}".to_sym : name
      raw_data[name] = result
    end

    def raw_data
      @raw_data ||= {}
    end

    def get_x id
      raw_data[id || ALL_DATA]
    end

  end
end
