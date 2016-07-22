module MyChart
  class Chart

    attr_reader :output_files

    def output *files_and_tmpl
      tmpl, files = extract_tmpl_file_address files_and_tmpl
      @output_files ||= []
      files.each do |f|
        @output_files << [f, tmpl]
      end
    end

    private

    def extract_tmpl_file_address args
      if args[-1].kind_of? Hash
        [args.pop[:tmpl], args]
      else
        [DEFAULT_TMPL, args]
      end
    end

  end
end
