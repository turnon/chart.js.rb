require 'x'

module MyChart
  class Chart

    def material dat=nil, &blk
      #@tasks.add ALL_DATA do |pre|
      #  objs = dat.nil? ? blk.call : dat
      #  X.new(objs)
      #end
      @__data__ = (dat ? dat : blk.call)
      raw_data[ALL_DATA] = @__data__
    end

    def select name, opt={}, &blk
      from = opt[:from] || ALL_DATA
      source = raw_data[from]
      raise Exception, '#{from} is not defined' unless source
      result = source.select &blk
      name = opt[:from] ? "#{name}__from__#{opt[:from]}".to_sym : name
      raw_data[name] = result
    end

    def raw_data
      @raw_data ||= {}
    end

  end
end
