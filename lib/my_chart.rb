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
  DEFAULT_TMPL = File.join File.dirname(__FILE__), 'tmpl.htm'

  class Chart

    attr_reader :tasks, :_charts, :chart_constructors

    def initialize
      @tasks = Tasks.new
      @chart_constructors = []
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

    def generate_charts
      @_charts = chart_constructors.map do |constructor|
        constructor.build
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

require 'dsl/material'
#require 'dsl/select'
require 'dsl/group'
require 'dsl/draw'
require 'dsl/output'
