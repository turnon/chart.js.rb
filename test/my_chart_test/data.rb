module MyChartTest::Data

  def test_material
    exp_data = make_x [1,2,3,4,5,6,7,8,9,10]
    assert_equal exp_data, @mc.raw_data[MyChart::ALL_DATA]
    assert_equal exp_data, @mc1.raw_data[MyChart::ALL_DATA]
  end

  def test_group_by_method
    assert @mc.group_by_methods[:odd_or_even]
  end

  def test_select_from_material
    assert_equal make_x([3,4,5,6,7,8,9,10]), @mc.raw_data[:ge3]
    assert_equal make_x([2,4,6,8,10]), @mc.raw_data[:x2]
  end

  def test_select_from_selected
    assert_equal make_x([4,6,8,10]), @mc.raw_data[:even__from__ge3]
  end

  #def test_x_to_xy
  #  assert_equal ({'even' => [2,4,6,8,10], 'odd' => [1,3,5,7,9]}), @mc.value(:GROUP_BY_odd_or_even)
  #  assert_equal ({'even' => [4,6,8,10], 'odd' => [3,5,7,9]}), @mc.value(:GROUP_ge3_BY_odd_or_even)
  #  assert_equal ({'divisible_by_3' => [6], 'not_divisible_by_3' => [4,8,10]}), @mc.value(:GROUP_even_FROM_ge3_BY_divisible_by_3)
  #end

  #def test_select_from_xy
  #  assert_equal ({1 => [1,4,7,10], 2 => [2,5,8]}), @mc.value(:not_divisible_by_3_FROM_GROUP_BY_mod3)
  #end

  #def test_xy_to_xyz
  #  exp = {'even' => {'gt3' => [4,6,8,10], 'not_gt3' => [2]}, 'odd' => {'gt3' => [5,7,9], 'not_gt3' => [1,3]}}
  #  assert_equal exp, @mc.value(:GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_3)
  #end
  #
  private

  def make_x objs
    X.new objs
  end
end
