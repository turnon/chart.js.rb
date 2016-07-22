class TestMyChart

  def test_define_output_file
    assert_includes @mc.output_files.flatten, @file
  end

  def test_can_create_file
    assert File.exist? @file
  end

  def test_output_bar_to_file
    assert_match /"type":"bar"."data":/, @content
  end

  def test_canvas
    assert_match %r{<html.*<canvas.*script>.*html>}m, @content
  end

  def test_canvas_size
    assert_match %r{width='1280'.*height='720'}m, @content
  end

  def test_canvas_size
    assert_match %r{width='1280'.*height='720'}m, @content
  end

  def test_output_to_more_than_one_file
    assert_equal @content, @content2
    assert_equal @content, @content3
  end

end
