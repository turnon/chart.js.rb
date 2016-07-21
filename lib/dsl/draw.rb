require 'chart/proto'

module MyChart
  class Chart

    Proto.derive.each do |chart_cmd|
      define_method chart_cmd do |opts={}, &group_cmd|
        constructor = {type: chart_cmd, task: group_cmd.call, opts: opts}
        chart_constructors << constructor
      end
    end

  end
end
