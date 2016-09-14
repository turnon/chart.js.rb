module MyChart
  class Chart

    def group_by method, &block
      group_by_methods[method] = block
    end

    def group_by_methods
      @group_by_methods ||= {}
    end

  end
end
