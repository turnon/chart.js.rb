require 'minitest/autorun'
require 'my_chart'

class TestMyChart < MiniTest::Unit::TestCase

  def test_material
    assert_equal [1,2,3,4,5,6,7,8,9,10], @mc.value(MyChart::ALL_DATA)
    assert_equal [1,2,3,4,5,6,7,8,9,10], @mc1.value(MyChart::ALL_DATA)
  end

  def test_select
    assert_equal [3,4,5,6,7,8,9,10], @mc.value(:ge3)
    assert_equal [2,4,6,8,10], @mc.value(:x2)
    assert_equal [4,6,8,10], @mc.value(:even_and_ge3)
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