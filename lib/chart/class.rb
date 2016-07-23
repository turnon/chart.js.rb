class Class
  def method_missing name, *args, &blk
    if name == :no_z_axis and self.name =~ /MyChartType::/
      define_method :no_z_axis? do
	true
      end
    else
      super
    end
  end
end
