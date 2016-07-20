class TestMyChart

  def test_methods_for_concrete_chart_type
    inst_ms = MyChart::Chart.instance_methods
    assert_includes inst_ms, :line
    assert_includes inst_ms, :bar
    assert_includes inst_ms, :pie
    assert_includes inst_ms, :doughnut
    assert_includes inst_ms, :polarArea
    assert_includes inst_ms, :radar
  end

  def test_concrete_chart_method
    exp = {'even' => {'gt3' => [4,6,8,10], 'not_gt3' => [2]}, 'odd' => {'gt3' => [5,7,9], 'not_gt3' => [1,3]}}
    assert_equal exp, @mc.value(:GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three)
  end

  def test_create_bar_chart
    assert_includes @mc.charts.map{|c| c.class}, Bar
    assert_includes @mc.charts.map{|c| c.id}, :bar_GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three
  end

end
