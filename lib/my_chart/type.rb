require 'my_chart/helper/string'
require 'my_chart/proto'

module MyChart::Type

  class << self

    include Enumerable

    def concrete type
      chart_class = detect{|klass| class_to_sym(klass) == type }
      raise Exception, "no such chart: #{type}" unless chart_class
      chart_class
    end

    def each &blk
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
      path = File.expand_path("../charts/*", __FILE__)
      Dir[path]
    end

    def custom_charts
      self.constants.map do |const|
        const_get(const)
      end.select do |klass|
        klass != MyChart::Proto
      end
    end

  end

end
