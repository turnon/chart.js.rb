require 'x'

module MyChart
  class Chart

    def material dat=nil, &blk
      @tasks.add ALL_DATA do |pre|
        objs = dat.nil? ? blk.call : dat
        X.new(objs)
      end
    end

  end
end
