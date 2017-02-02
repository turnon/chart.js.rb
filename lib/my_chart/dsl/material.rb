require 'my_chart/x'

module MyChart
  module Dsl
    module Material

      def material dat=nil, name: ALL_DATA, &blk
        data = (dat ? dat : blk.call)
        raw_data[name] = MyChart::X.new data
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
end
