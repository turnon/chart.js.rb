class Line < MyChart::Proto

  def concrete_type
    :line
  end

  def concrete_style
    {fill:false, lineTension: 0.1}
  end

  def concrete_options
    opt = {}
    opt.merge!({legend: {display: false}}) unless has_z?
    opt
  end

end
