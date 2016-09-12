require 'x'

module MyChart
  class Chart

    def material dat=nil, &blk
      @tasks.add ALL_DATA do |pre|
        objs = dat.nil? ? blk.call : dat
        X.new(objs)
      end

      if dat
        @__data__ = dat
        return
      end
      @__data__ = blk.call
    end

  end
end
