require 'minitest/autorun'
require 'charts/bar'
require 'mock_data'

class TestBar < MiniTest::Unit::TestCase

  def test_tojs    
    json = @bar.json
    assert_match /"type":"bar"."data":/, json
  end

  def test_derive    
    assert_includes Proto.derive, :bar
  end

  def setup
    @bar = Bar.new mock_data_xy
  end
end