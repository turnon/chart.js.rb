class Bar < Proto

  include Z

  def dataset_options
    {fill: false}
  end

  def chart_options
    {}
  end

end