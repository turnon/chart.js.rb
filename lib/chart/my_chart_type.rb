require 'helper/string'
require 'chart/proto'

module MyChartType

  class << self

    include Enumerable

    #def load
    #  load_proto
    #  load_concrete_charts
    #end

    #def concrete constructor
    #  begin
    #    chart_class = const_get constructor.type_class
    #  rescue NameError
    #    raise Exception, "no such chart: #{constructor.type}" unless chart_class
    #  end
    #  chart_class.new constructor
    #end

    def concrete type
      chart_class = detect{|klass| class_to_sym(klass) == type }
      raise Exception, "no such chart: #{type}" unless chart_class
      chart_class
    end

    def each &blk
      #load
      load_concrete_charts
      custom_charts.each &blk
    end

    def each_sym &blk
      map{ |klass| class_to_sym klass }.each &blk
    end

    def load_concrete_charts
      return if @loaded
      definitions.each do |c|
        class_eval File.read(c)
      end
      @loaded = true
    end

    private

    def class_to_sym klass
      basename(klass).anticapitalize.to_sym
    end

    def basename klass
      klass.name.split(/::/)[-1]
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
