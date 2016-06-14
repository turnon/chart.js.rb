class RGBA

  attr_reader :a

  [:r, :g, :b].each do |color|
    define_method color do
      c = instance_variable_get ['@', color].join.to_sym
      c > 255 ? 255 : c
    end
  end

  def initialize color={}
    @r,@g,@b,@a = color[:r] || rand_light_color, color[:g] || rand_light_color, color[:b] || rand_light_color, color[:a] || light_alpha
  end

  def notation
    "rgba(#{r},#{g},#{b},#{a})"
  end

  def darker scalar=10
    RGBA.new({r: (r+scalar), g: (g+scalar), b: (b+scalar)})
  end

  private

  def rand_light_color
    rand 128
  end

  def light_alpha
    0.2
  end
end