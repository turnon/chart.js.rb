require 'minitest/autorun'
require 'xy'
require 'xyz'

class MiniTest::Unit::TestCase

  private
  
  def mock_data_task_xyz
    m = mock
    m.expect :result, mock_xyz
    m.expect :id, :group_by_mod_and_even_or_not
    m
  end

  def mock_data_xyz
    m = mock
    m.expect :data, mock_xyz
    m.expect :id, :group_by_mod_and_even_or_not
    m
  end

  def mock_xyz
    XYZ.new({0 => {'even' => [6,12,18], 'odd' => [3,9,15]},
       1 => {'even' => [4,10,16], 'odd' => [1,7,13,19]},
       2 => {'even' => [2,8,14,20], 'odd' => [5,11,17]}})
  end

  def mock_data_task_xy
    m = mock
    m.expect :result, mock_xy
    m.expect :id, :group_by_abcdef
    m
  end

  def mock_data_xy
    m = mock
    m.expect :data, mock_xy
    m.expect :id, :group_by_abcdef
    m
  end

  def mock_xy
    XY.new({:a => [1,2,3,4,5,6], :b => [1,2,3], :c => [1,2,3,4], :d => [1], :f => [1,2]})
  end
  
  def mock
    m = MiniTest::Mock.new
    m.expect :w, :nil
    m.expect :h, :nil
    m
  end
end