class Module
  def exclude *modules
    modules.each do |m|
      m.excluded self
    end
  end
end