require 'my_chart/rainbow'
require 'json'
require 'my_chart/xyz'

module MyChart
  class Proto

    attr_reader :id

    class << self

      def no_z_axis
        define_method :no_z_axis? do
          true
        end
      end

      def same_color_on_x
	define_method :styled_datasets do
          diff_color_on_z
	end
      end

    end

    def initialize grouped_data, opt={}
      raise Exception, "#{type} has no z axis" if grouped_data.kind_of? MyChart::XYZ and no_z_axis?
      @id = opt[:id]
      @grouped_data = grouped_data
      @width = opt[:w]
      @height = opt[:h]
    end

    def labels
      @grouped_data.labels
    end

    def datasets
      @grouped_data.datasets
    end

    def json
      {
       type: type,
       data: {
         labels: labels,
         datasets: styled_datasets
         },
       options: options
      }.to_json
    end

    def iife
      "(function(){
        var ctx = document.getElementById('#{id}');
        var myChart = new Chart(ctx, #{json});
      })();"
    end

    def default_html
      "<div><canvas id='#{id}' width='#{width}' height='#{height}'></canvas><script>#{iife}</script></div>"
    end

    def width
      @width || 800
    end

    def height
      @height || 300
    end

    def concrete_type
    end

    def type
      concrete_type || :proto
    end

    def concrete_options
      {}
    end

    def options
      {responsive: false}.merge concrete_options
    end

    def concrete_style
      {}
    end

    def styled_datasets
      datasets.size > 1 ? diff_color_on_z : diff_color_on_x
    end

    def diff_color_on_z
      colors = Rainbow[datasets.size].map do |color|
        {borderColor: color.to_s,
         backgroundColor: color.alpha(0.2).to_s,
         borderWidth: 1}
      end
      datasets.zip(colors).map do |ds, col|
        ds.merge(col).merge concrete_style
      end
    end

    def diff_color_on_x
      [datasets[0].merge({
        backgroundColor: Rainbow[labels.size].map(&:to_s)
      })]
    end

    def no_z_axis?
      false
    end

  end
end
