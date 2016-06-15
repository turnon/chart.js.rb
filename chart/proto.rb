require 'helper/string'
require 'helper/module'
require 'chart/js'
require 'chart/xy'
require 'chart/z'

class Proto

  include Js
  include XY
  
  class << self
    def inherited concrete
      (@concrete ||= {})[concrete.name.anticapitalize.to_sym] = concrete
      concrete.singleton_class.class_eval do
        define_method :inherited do |sub|
        end
      end
    end
    
    def [] type
      @concrete[type.to_sym]
    end
    
    def list
      @concrete.keys
    end
  end

end