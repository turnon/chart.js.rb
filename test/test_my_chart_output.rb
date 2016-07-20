class TestMyChart

  def test_define_output_file
    assert_includes @mc.output_files, @file
  end

  def test_can_create_file
    assert File.exist? @file
  end

  def test_output_bar_to_file
    assert_match /"type":"bar"."data":/, @content
  end

  def test_canvas
    assert_match /<html.*<canvas.*script>.*html>/m, @content
  end

end
