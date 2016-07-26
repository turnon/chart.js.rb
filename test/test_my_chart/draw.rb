module MyChartTest::Draw

  def test_concrete_chart_method
    exp = {'even' => {'gt3' => [4,6,8,10], 'not_gt3' => [2]}, 'odd' => {'gt3' => [5,7,9], 'not_gt3' => [1,3]}}
    assert_equal exp, @mc.value(:GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three)
  end

  def test_create_bar_chart
    assert_includes @mc.charts.map{|c| c.class}, MyChartType::Bar
    assert_includes @mc.charts.map{|c| c.id}, :bar_GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three
  end

end
