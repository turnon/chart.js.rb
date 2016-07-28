require 'minitest/autorun'
require 'my_chart'

class TestGroupByARGV < MiniTest::Unit::TestCase

  GroupByARGV = MyChart::Chart::GroupByARGV

  def test_base_on_all_data
    arg = GroupByARGV.new by: :gender
    assert_equal MyChart::ALL_DATA, arg.material_id
    assert_equal :GROUP_BY_gender, arg.production_id
  end

  def test_base_on_specified_data
    arg = GroupByARGV.new :people, by: :age
    assert_equal :people, arg.material_id
    assert_equal :GROUP_people_BY_age, arg.production_id
  end
end