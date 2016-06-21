require 'minitest/autorun'
require 'my_chart'

class TestMyChart < MiniTest::Unit::TestCase

  def test_material
    all_material = @mc.get MyChart::ALL_DATA
    assert_equal [1,2,3,4,5,6,7,8,9,10], all_material.value

    all_material_defined_by_block = @mc1.get MyChart::ALL_DATA
    assert_equal [1,2,3,4,5,6,7,8,9,10], all_material_defined_by_block.value
  end

  def test_select
    greater_or_equals_3 = @mc.get :ge3
    assert_equal [3,4,5,6,7,8,9,10], greater_or_equals_3.value

    even_numbers = @mc.get :x2
    assert_equal [2,4,6,8,10], even_numbers.value

    ge3_and_even = @mc.get :even_and_ge3
    assert_equal [4,6,8,10], ge3_and_even.value
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

    end

    @mc1 = MyChart.js do
      material do
        (1..10).to_a
      end
    end

  end
end