require 'minitest/autorun'
require 'chart/proto'
require 'mock_data'

class TestProto < MiniTest::Unit::TestCase

  def test_tojs    
    json = @proto.json

    assert_kind_of String, json

    rgba_opt = json.scan /rgba/
    assert_equal 4, rgba_opt.length

    labels_opt = json.scan /(labels)/
    assert_equal 1, labels_opt.length

    datasets_opt = json.scan /(datasets)/
    assert_equal 1, datasets_opt.length
  end

  def test_iife
    assert_match %r$\(function\(\){.*}\)\(\);$m, @proto.iife
  end

  def setup
    @proto = Test.new mock_xyz
  end

  class Test < MyChartType::Proto
  end
end
