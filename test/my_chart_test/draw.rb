module MyChartTest::Draw

  def test_bar_x
    exp_data = make_xy 1=>[1, 4, 7, 10], 2=>[2, 5, 8], 0=>[3, 6, 9]
    assert_equal exp_data, @mc.grouped[[:mod3, nil]]
    assert @mc.charts[:bar__mod3__no_y__no_keys__from_all__order_by_key]
  end

  def test_bar_x_y
    exp_data = make_xyz 1=>{true: [10], false: [1,4,7]}, 2=>{true: [5], false: [2,8]}, 0=>{false: [3,6,9]}
    assert_equal exp_data, @mc.grouped[[:mod3, :x5, nil, nil]]
    assert @mc.charts[:bar__mod3__x5__no_keys__from_all]
  end

  def test_cache_tmp_grouped_data
    obj = @mc.grouped[[:mod3, nil]].value[1][0]
    assert_equal 1, obj.mod3_exe
    assert_equal 1, obj.x5_exe
  end

  def test_custom_group_by_method_on_x
    exp_data = make_xy 'odd' => [1,3,5,7,9], 'even' => [2,4,6,8,10]
    assert_equal exp_data, @mc.grouped[[:odd_or_even, nil]]
  end

  def test_custom_group_by_method_on_y
    exp_data = make_xyz 1=>{'odd' => [1,7], 'even' => [4,10]}, 2=>{'odd' => [5], 'even' => [2,8]}, 0=>{'odd' => [3,9], 'even' => [6]}
    assert_equal exp_data, @mc.grouped[[:mod3, :odd_or_even, nil, nil]]
  end

  def test_pie_x_from
    exp_data = make_xy true: [5,10], false:[3,4,6,7,8,9]
    assert_equal exp_data, @mc.grouped[[:x5, :ge3]]
  end

  def test_line_x_y_from
    exp_data = make_xyz :true=> {2=>[5], 1=>[10]}, :false=> {0=>[3,6,9], 1=>[4,7], 2=>[8]}
    assert_equal exp_data, @mc.grouped[[:x5, :mod3, nil, :ge3]]
  end

  def test_bar_x_keys
    exp_data = make_xy 1=>[1, 4, 7, 10], 2=>[2, 5, 8], 0=>[3, 6, 9], 3=>[]
    require 'pp'
    pp @mc.grouped
    assert_equal exp_data, @mc.grouped[[:mod3, [0,1,2,3], nil]]
  end

  private

  def make_xy *arg
    XY.new *arg
  end

  def make_xyz *arg
    XYZ.new *arg
  end
end
