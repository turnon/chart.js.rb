require 'minitest/autorun'
require 'charts/pie'
require 'mock_data'

class TestPie < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"pie"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :pie
  end

  def setup
    @ch = Pie.new mock_data_xy
  end
end
