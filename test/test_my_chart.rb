require 'minitest/autorun'
require 'my_chart'

class TestMyChart < MiniTest::Unit::TestCase

  def test_material
    assert_equal [1,2,3,4,5,6,7,8,9,10], @mc.value(MyChart::ALL_DATA)
    assert_equal [1,2,3,4,5,6,7,8,9,10], @mc1.value(MyChart::ALL_DATA)
  end

  def test_select_from_material
    assert_equal [3,4,5,6,7,8,9,10], @mc.value(:ge3)
    assert_equal [2,4,6,8,10], @mc.value(:x2)
  end

  def test_select_from_selected
    assert_equal [4,6,8,10], @mc.value(:even_FROM_ge3)
  end

  def test_x_to_xy
    assert_equal ({'even' => [2,4,6,8,10], 'odd' => [1,3,5,7,9]}), @mc.value(:GROUP_BY_odd_or_even)
    assert_equal ({'even' => [4,6,8,10], 'odd' => [3,5,7,9]}), @mc.value(:GROUP_ge3_BY_odd_or_even)
    assert_equal ({'divisible_by_3' => [6], 'not_divisible_by_3' => [4,8,10]}), @mc.value(:GROUP_even_FROM_ge3_BY_divisible_by_3)
  end

  def test_select_from_xy
    assert_equal ({1 => [1,4,7,10], 2 => [2,5,8]}), @mc.value(:not_divisible_by_3_FROM_GROUP_BY_mod3)
  end

  def test_xy_to_xyz
    exp = {'even' => {'gt3' => [4,6,8,10], 'not_gt3' => [2]}, 'odd' => {'gt3' => [5,7,9], 'not_gt3' => [1,3]}}
    assert_equal exp, @mc.value(:GROUP_BY_odd_or_even_AND_THEN_GROUP_BY_greater_than_3)
  end

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
  end

  def setup
    @mc = MyChart.js do
      material [1,2,3,4,5,6,7,8,9,10]

      select :even, from: :ge3 do |obj|
        obj.even?
      end

      select :ge3 do |obj|
        obj >= 3
      end

      select :x2, &:even?

      group :even_FROM_ge3, by: :divisible_by_3 do |n|
        (n % 3 == 0) ? 'divisible_by_3' : 'not_divisible_by_3'
      end

      group :ge3, by: :odd_or_even do |n|
        n.odd? ? 'odd' : 'even'
      end

      group by: :odd_or_even do |n|
        n.odd? ? 'odd' : 'even'
      end

      group by: :mod3 do |n|
        n % 3
      end

      select :not_divisible_by_3, from: :GROUP_BY_mod3 do |mod3|
        not mod3.zero?
      end

      group :GROUP_BY_odd_or_even, by: :greater_than_3 do |n|
        n > 3 ? 'gt3' : 'not_gt3'
      end

      bar do
        group :GROUP_BY_odd_or_even, by: :greater_than_three do |n|
          n > 3 ? 'gt3' : 'not_gt3'
        end
      end
    end

    @mc1 = MyChart.js do
      material do
        (1..10).to_a
      end
    end

  end
end
