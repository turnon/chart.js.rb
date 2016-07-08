require 'minitest/autorun'
require 'charts/doughnut'

class TestDoughnut < MiniTest::Unit::TestCase

  def test_tojs    
    json = @ch.json
    assert_match /"type":"doughnut"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :doughnut
  end

  def setup
    xy = XY.new({:a => [1,2,3,4,5,6], :b => [1,2,3], :c => [1,2,3,4], :d => [1], :f => [1,2]})
    @ch = Doughnut.new xy
  end
end
