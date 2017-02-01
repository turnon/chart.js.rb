class Radar < MyChart::Proto

  def concrete_type
    :radar
  end

  def concrete_options
    {legend: {display: false}}
  end

end
