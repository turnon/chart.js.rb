require 'chart/rainbow'
require 'helper/string'
require 'json'

class Proto

  class << self
    def inherited concrete
      (@concretes ||= {})[concrete.name.anticapitalize.to_sym] = concrete
    end

    def derive
      @concretes.keys
    end
  end

  def initialize grouped_data
    @grouped_data = grouped_data
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
      {borderColor: color,
       backgroundColor: color.alpha(0.2),
       borderWidth: 1}
    end
    datasets.zip(colors).map do |ds, col|
      ds.merge(col).merge concrete_style
    end
  end

  def diff_color_on_x
    [datasets[0].merge({
      backgroundColor: Rainbow[labels.size]
    })]
  end

end