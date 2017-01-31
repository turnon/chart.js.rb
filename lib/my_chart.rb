require 'erb'
require 'my_chart/dsl/material'
require 'my_chart/dsl/group'
require 'my_chart/dsl/draw'
require 'my_chart/dsl/output'

module MyChart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart.generate
      @chart
    end

  end

  ALL_DATA = :__all_data__
  DEFAULT_TMPL = File.join File.dirname(__FILE__), 'tmpl.htm'

  class Chart

    include MyChart::Dsl::Material
    include MyChart::Dsl::Group
    include MyChart::Dsl::Draw
    include MyChart::Dsl::Output

    attr_reader :chart_tags

    def generate
      generate_charts
      generate_files
    end

    private

    def generate_charts
      @chart_tags = charts.map do |id, chart|
        chart
      end
    end

    def generate_files
      output_files and output_files.each do |path, tmpl|
        File.open path, 'w:utf-8' do |f|
          f.puts filled_template tmpl
        end
      end
    end

    def filled_template tmpl_file
      @filled ||= {}
      return @filled[tmpl_file] if @filled[tmpl_file]
      @filled[tmpl_file] = ERB.new(File.read tmpl_file).result(binding)
    end

  end

end
