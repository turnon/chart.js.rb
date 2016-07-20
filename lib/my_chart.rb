require 'tasks'
require 'erb'

module MyChart

  class << self

    def js &blk
      @chart = Chart.new
      @chart.instance_exec &blk
      @chart.generate
      @chart
    end

  end

  ALL_DATA = Tasks::ROOT

  class Chart

    attr_reader :tasks, :charts

    def initialize
      @tasks = Tasks.new
      @chart_type_and_id_s = []
    end

    def generate
      tasks.exe
      generate_charts
      generate_files
    end

    def result name
      tasks[name.to_sym].result
    end

    def value name
      result(name).value
    end

    private

    def type_and_labels_datasets *type_and_id
      [type_and_id[0], result(type_and_id[1])]
    end

    def generate_charts
      @charts = @chart_type_and_id_s.map do |type_and_id|
        chart = Proto.concrete *type_and_labels_datasets(*type_and_id)
        chart.id = [*type_and_id].join('_').to_sym
        chart
      end
    end

    def generate_files
      output_files and output_files.each do |path|
        File.open path, 'w:utf-8' do |f|
          f.puts filled_template
        end
      end
    end

    def filled_template
      return @filled if @filled
      tmpl_file = File.join File.dirname(__FILE__), 'tmpl.htm'
      @filled = ERB.new(File.read tmpl_file).result(binding)
    end

  end

end

require 'dsl/material'
require 'dsl/select'
require 'dsl/group'
require 'dsl/draw'
require 'dsl/output'
