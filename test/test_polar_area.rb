require 'minitest/autorun'
require 'charts/polar_area'
require 'mock_data'

class TestPolarArea < MiniTest::Unit::TestCase

  def test_tojs
    json = @ch.json
    assert_match /"type":"polarArea"."data":/, json
  end

  def test_derive
    assert_includes Proto.derive, :polarArea
  end

  def test_no_z_axis
    ex = assert_raises(Exception) do
      PolarArea.new mock_data_xyz
    end
    assert_equal 'polarArea has no z axis', ex.message
  end

  def setup
    @ch = PolarArea.new mock_data_xy
  end
end
