require 'json'
require 'chart/rgba'

module Js
  def js
    <<-EOS
      <div>
        #{canvas + script}
      </div>
    EOS
  end

  class Style < BasicObject
    def initialize opts={}
      @opts = opts
    end
    
    def method_missing style, *args, &blk
      @opts[style]
    end
  end

  private

  def acceptStyle opts={}
    @name = opts[:name]
    @style = Style.new opts
  end

  def name
    @name
  end

  def style
    @style
  end

  def mergedDatasets
    datasets.map{ |ds| ds.merge(dataset_options).merge(color)}
  end

  def mergedOptions
    chart_options.merge({responsive: false})
  end

  def color
    color = RGBA.new
    {
     borderColor: color.notation,
     backgroundColor: color.darker.notation
    }
  end

  def canvas
    <<-EOS
      <canvas id="#{name}" width="#{width}" height="#{height}"></canvas>
    EOS
  end

  def width
    style.width || 600
  end

  def height
    style.height || 300
  end

  def script
    <<-EOS
      <script>
        var ctx = document.getElementById("#{name}");
        var myChart = new Chart(ctx, #{json});
      </script>
    EOS
  end

  def json
    {type: type,
     data: {labels: labels, datasets: mergedDatasets},
     options: mergedOptions
    }.to_json
  end
end