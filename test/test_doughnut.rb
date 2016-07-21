require 'minitest/autorun'
require 'charts/doughnut'
require 'mock_data'

class TestDoughnut < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"doughnut"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :doughnut
  end

  def setup
    @ch = Doughnut.new mock_data_xy
  end
end
