require 'tempfile'

module FileOp

  private

  def tmpfile_path seq=''
    File.join Dir.tmpdir, (Time.now.strftime('%Y%m%d%H%M%S') + '_' +  seq.to_s + '.html')
  end

  def read_f file
    File.read file if File.exist? file
  end

  def del_f *files
    files.each do |f|
      File.delete f if not f.nil? and File.exist? f
    end
  end
end
