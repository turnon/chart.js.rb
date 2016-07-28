module MyChartTest;end

Dir[File.join(File.dirname(__FILE__), '*')].select do |f|
  f != __FILE__
end.each do |f|
  require f
end
