require 'minitest/autorun'
require 'my_chart'
require 'tempfile'

class TestMyChart < MiniTest::Unit::TestCase

  def setup

    file = [Dir.tmpdir, Time.now.strftime('%Y%m%d%H%M%S') + '.html'].join(File::SEPARATOR)

    @mc = MyChart.js do
      material [1,2,3,4,5,6,7,8,9,10]

      select :even, from: :ge3 do |obj|
        obj.even?
      end

      select :ge3 do |obj|
        obj >= 3
      end

      select :x2, &:even?

      group :even_FROM_ge3, by: :divisible_by_3 do |n|
        (n % 3 == 0) ? 'divisible_by_3' : 'not_divisible_by_3'
      end

      group :ge3, by: :odd_or_even do |n|
        n.odd? ? 'odd' : 'even'
      end

      group by: :odd_or_even do |n|
        n.odd? ? 'odd' : 'even'
      end

      group by: :mod3 do |n|
        n % 3
      end

      select :not_divisible_by_3, from: :GROUP_BY_mod3 do |mod3|
        not mod3.zero?
      end

      group :GROUP_BY_odd_or_even, by: :greater_than_3 do |n|
        n > 3 ? 'gt3' : 'not_gt3'
      end

      bar do
        group :GROUP_BY_odd_or_even, by: :greater_than_three do |n|
          n > 3 ? 'gt3' : 'not_gt3'
        end
      end

      output file

    end

    @file = file

    @mc1 = MyChart.js do
      material do
        (1..10).to_a
      end
    end

  end

  def teardown
    File.delete @file if File.exist? @file
  end
end
