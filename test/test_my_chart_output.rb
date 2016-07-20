class TestMyChart

  def test_define_output_file
    assert_includes @mc.output_files, @file
  end

  def test_can_create_file
    assert File.exist? @file
  end

  def test_output_bar_to_file
    content = File.read @file
    assert_match /"type":"bar"."data":/, content
  end

end
