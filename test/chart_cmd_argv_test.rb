require 'minitest/autorun'
require 'my_chart'

class TestChartCmdARGV < MiniTest::Unit::TestCase

  EMPTY_HASH = {}

  def test_no_argv
    argv = new_cmd
    assert_equal nil, argv.opt
    assert_equal nil, argv.x
    assert_equal nil, argv.y
  end

  def test_only_x
    argv = new_cmd :country
    assert_equal EMPTY_HASH, argv.opt
    assert_equal :country, argv.x
    assert_equal nil, argv.y
  end

  def test_xy_no_opt
    argv = new_cmd :country, :gender
    assert_equal EMPTY_HASH, argv.opt
    assert_equal :country, argv.x
    assert_equal :gender, argv.y
  end

  def test_only_opt
    argv = new_cmd w: 640, h: 480
    assert_equal({w: 640, h: 480}, argv.opt)
    assert_equal nil, argv.x
    assert_equal nil, argv.y
  end

  def test_limit
    argv = new_cmd first: 10
    assert_equal 10, argv.first
    assert_equal nil, argv.last
  end

  private

  def new_cmd *arg
    MyChart::Chart::ChartCmdARGV.new *arg
  end
end
