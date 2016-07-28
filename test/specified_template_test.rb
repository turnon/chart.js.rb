require 'minitest/autorun'
require 'my_chart'
require 'file_op'

class TestSpecifiedTemplate < MiniTest::Unit::TestCase

  include FileOp

  def setup

    file = tmpfile_path
    template = mock_tmpl

    @mc = MyChart.js do
      material [1,2,3,4,5,6,7,8,9,10]

      bar w: 1280, h: 720 do
        group by: :mod3 do |n|
          n % 3
        end
      end

      output file, tmpl: template

    end

    @file = file

  end
  
  def test_specified_template
    content = read_f @file
    assert_includes @mc.output_files.flatten, mock_tmpl
    assert_equal "1234\n", content
  end

  def teardown
    del_f @file, mock_tmpl
  end

  private

  def mock_tmpl
    return @mock_tmpl if @mock_tmpl
    @mock_tmpl = tmpfile_path 999
    File.open @mock_tmpl, 'w:utf-8' do |f|
      f.puts 1234
    end
    @mock_tmpl
  end
end
