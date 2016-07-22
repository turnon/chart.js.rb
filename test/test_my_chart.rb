require 'minitest/autorun'
require 'my_chart'
require 'tempfile'

class TestMyChart < MiniTest::Unit::TestCase

  def setup

    file = tmpfile_path
    file2 = tmpfile_path 2
    file3 = tmpfile_path 3
    file4 = tmpfile_path 4

    tmpl = mock_tmpl

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

      bar w: 1280, h: 720 do
        group :GROUP_BY_odd_or_even, by: :greater_than_three do |n|
          n > 3 ? 'gt3' : 'not_gt3'
        end
      end

      output file
      output file2, file3
      #output file4, tmpl: tmpl

    end

    @file = file
    @file2 = file2
    @file3 = file3
    @file4 = file4

    @content = read_f @file
    @content2 = read_f @file2
    @content3 = read_f @file3
    #@content4 = read_f @file4

    @mc1 = MyChart.js do
      material do
        (1..10).to_a
      end
    end

  end

  def teardown
    del_f @file, @file2, @file3, @file4, @mock_tmpl
  end

  private

  def tmpfile_path seq=''
    File.join Dir.tmpdir, (Time.now.strftime('%Y%m%d%H%M%S') + '_' +  seq.to_s + '.html')
  end

  def read_f file
    File.read file if File.exist? file
  end

  def del_f *files
    files.each do |f|
      File.delete f if File.exist? f
    end
  end

  def mock_tmpl
    return @mock_tmpl if @mock_tmpl
    @mock_tmpl = tmpfile_path 999
    File.open @mock_tmpl, 'w:utf-8' do |f|
      f.puts 1234
    end
  end
end
