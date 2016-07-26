require 'helper/string'

module MyChartType

  class << self

    include Enumerable

    def load
      load_proto
      load_concrete_charts
    end

    def concrete constructor
      begin
        chart_class = const_get constructor.type_class
      rescue NameError
        raise Exception, "no such chart: #{constructor.type}" unless chart_class
      end
      chart_class.new constructor
    end

    def each &blk
      load
      custom_charts.each &blk
    end

    def each_sym &blk
      map{ |klass| basename(klass).anticapitalize.to_sym }.each &blk
    end

    private

    def basename klass
      klass.name.split(/::/)[-1]
    end

    def load_concrete_charts
      definitions.each do |c|
        class_eval File.read(c)
      end
    end

    def load_proto
      require 'chart/proto'
    end

    def definitions
      path = File.expand_path("../../charts/*", __FILE__)
      Dir[path]
    end

    def custom_charts
      self.constants.map do |const|
        const_get(const)
      end.select do |klass|
        klass != Proto
      end
    end

  end

end
