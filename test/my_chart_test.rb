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

    #file = tmpfile_path
    #file2 = tmpfile_path 2
    #file3 = tmpfile_path 3

    @mc = MyChart.js do
      material do
	(1..10).map{|n| WrappedNum.new n}
      end

      bar :mod3

      bar :mod3, :x5

      #select :even, from: :ge3 do |obj|
      #  obj.even?
      #end

      #select :ge3 do |obj|
      #  obj >= 3
      #end

      #select :x2, &:even?

      #group :even_FROM_ge3, by: :divisible_by_3 do |n|
      #  (n % 3 == 0) ? 'divisible_by_3' : 'not_divisible_by_3'
      #end

      #group :ge3, by: :odd_or_even do |n|
      #  n.odd? ? 'odd' : 'even'
      #end

      #group by: :odd_or_even do |n|
      #  n.odd? ? 'odd' : 'even'
      #end

      #group by: :mod3 do |n|
      #  n.mod3
      #end

      #select :not_divisible_by_3, from: :GROUP_BY_mod3 do |mod3|
      #  not mod3.zero?
      #end

      #group :GROUP_BY_odd_or_even, by: :greater_than_3 do |n|
      #  n > 3 ? 'gt3' : 'not_gt3'
      #end

      #complex_bar w: 1280, h: 720 do
      #  group :GROUP_BY_odd_or_even, by: :greater_than_three do |n|
      #    n > 3 ? 'gt3' : 'not_gt3'
      #  end
      #end

      #output file
      #output file2, file3

    end

    #@file = file
    #@file2 = file2
    #@file3 = file3

    #@content = read_f @file
    #@content2 = read_f @file2
    #@content3 = read_f @file3

    @mc1 = MyChart.js do
      material [1,2,3,4,5,6,7,8,9,10]
    end

  end

  #def teardown
  #  del_f @file, @file2, @file3
  #end
end
