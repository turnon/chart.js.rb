require 'chart/proto'

module MyChart
  class Chart

    Proto.derive.each do |chart_cmd|
      define_method chart_cmd do |&group_cmd|
        @chart_type_and_id_s << [chart_cmd, group_cmd.call]
      end
    end

  end
end
