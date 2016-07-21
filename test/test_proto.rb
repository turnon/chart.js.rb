require 'minitest/autorun'
require 'chart/proto'
require 'xyz'

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

  def test_auto_load_default_charts
    assert_includes Proto.derive, :line
    assert_includes Proto.derive, :bar
    assert_includes Proto.derive, :pie
    assert_includes Proto.derive, :radar
    assert_includes Proto.derive, :doughnut
    assert_includes Proto.derive, :polarArea
  end

  def test_iife
    assert_match %r$\(function\(\){.*}\)\(\);$m, @proto.iife
  end

  def setup
    xyz = XYZ.new({0 => {'even' => [6,12,18], 'odd' => [3,9,15]},
           1 => {'even' => [4,10,16], 'odd' => [1,7,13,19]},
           2 => {'even' => [2,8,14,20], 'odd' => [5,11,17]}})
    @proto = Proto.new data: xyz
  end
end
