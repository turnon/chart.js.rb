require 'helper/string'

module MyChartType

  class << self

    include Enumerable

    def load
      load_concrete_charts
      add_charts_instance_methods
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
      klass.name.split(/::/)[1]
    end


    def load_concrete_charts
      add_charts_class_methods
      chart_definitions.each do |c|
        require c
      end
    end

    def chart_definitions
      path = File.expand_path("../../charts/*", __FILE__)
      Dir[path]
    end

    def add_charts_class_methods
      require 'chart/class'
    end
    
    def add_charts_instance_methods
      require 'chart/proto'
      custom_charts.each do |const|
        const.include Proto
      end
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
