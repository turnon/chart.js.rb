Gem::Specification.new do |s|

  s.name = %q{mychartjs}
  s.version = "0.0.0"
  s.date = %q{2016-06-15}
  s.authors = ["zp yuan"]
  s.summary = %q{chart.js wrapper}

  s.files = Dir.glob("bin/*") +  Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.executables = ["mychartjs"]

end