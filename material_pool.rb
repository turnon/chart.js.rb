class MaterialPool

  def initialize
    @p = {}
  end

  def get name
    @p[name]
  end

  def put name, material
    @p[name] = material
  end

  def production
    @p.select do |name, material|
      material.respond_to? :js
    end
  end

end