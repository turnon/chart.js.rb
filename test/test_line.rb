require 'minitest/autorun'
require 'charts/line'
require 'mock_data'

class TestLine < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"line"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :line
  end

  def setup
    @ch = Line.new mock_data_xyz
  end
end