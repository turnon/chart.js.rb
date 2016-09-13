module MyChartTest::Draw

  #def test_concrete_chart_method
  #  exp = {'even' => {'gt3' => [4,6,8,10], 'not_gt3' => [2]}, 'odd' => {'gt3' => [5,7,9], 'not_gt3' => [1,3]}}
  #  assert_equal exp, @mc.value(:GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three)
  #end

  #def test_create_bar_chart
  #  assert_includes @mc.charts.map{|c| c.class}, MyChartType::Bar
  #  assert_includes @mc.charts.map{|c| c.id}, :bar_GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_three
  #end
  #
  def test_bar_x
    exp_data = {1=>[1, 4, 7, 10], 2=>[2, 5, 8], 0=>[3, 6, 9]}
    assert_equal exp_data, @mc.grouped[:mod3].value
    assert @mc.charts[:bar__mod3]
  end

  def test_bar_x_y
    exp_data = {1=>{true: [10], false: [1,4,7]}, 2=>{true: [5], false: [2,8]}, 0=>{false: [3,6,9]}}
    assert_equal exp_data, @mc.grouped[:mod3__x5].value
    assert @mc.charts[:bar__mod3__x5]
  end

end
