require 'minitest/autorun'
require 'my_chart'

class TestSelectFromARGV < MiniTest::Unit::TestCase

  SelectFromARGV = MyChart::Chart::SelectFromARGV

  def test_base_on_all_data
    arg = SelectFromARGV.new :female
    assert_equal MyChart::ALL_DATA, arg.material_id
    assert_equal :female, arg.production_id
  end

  def test_base_on_specified_data
    arg = SelectFromARGV.new :male, from: :children
    assert_equal :children, arg.material_id
    assert_equal :male_from_children, arg.production_id
  end
end