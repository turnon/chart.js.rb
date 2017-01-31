class Line < MyChart::Proto

  def concrete_type
    :line
  end

  def concrete_style
    {fill:false, lineTension: 0.1}
  end

end
