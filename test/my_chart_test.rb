require 'minitest/autorun'
require 'my_chart'
require 'file_op'
require 'wrapped_num'
require 'my_chart_test/integrate'

class TestMyChart < MiniTest::Unit::TestCase

  include FileOp

  MyChartTest.constants.each do |c|
    include MyChartTest.const_get(c)
  end

  def setup

    file = tmpfile_path
    file2 = tmpfile_path 2
    file3 = tmpfile_path 3

    @mc = MyChart.js do
      material do
	(1..10).map{|n| WrappedNum.new n}
      end

      select :ge3, &-> n {n >= 3}
      select :even, from: :ge3, &-> n {n.even?}
      select :x2, &:even?

      group_by :odd_or_even, &-> n {n.odd? ? 'odd' : 'even'}

      bar  :mod3
      bar  :mod3, :x5
      line :mod3, :x5
      pie  :x5, from: :ge3
      line :x5, :mod3, from: :ge3
      bar  :odd_or_even
      bar  :mod3, :odd_or_even, w: 1280, h: 720
      bar  :mod3, keys: [0,1,2,3]

      output file
      output file2, file3

    end

    @file = file
    @file2 = file2
    @file3 = file3

    @content = read_f @file
    @content2 = read_f @file2
    @content3 = read_f @file3

    @mc1 = MyChart.js do
      material [1,2,3,4,5,6,7,8,9,10]
    end

  end

  def teardown
    del_f @file, @file2, @file3
  end
end
