module MyChart
  class Chart
  
    attr_reader :output_files

    def output *files
      @output_files = files
    end

  end
end
