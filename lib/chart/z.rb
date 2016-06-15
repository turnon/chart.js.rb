module Z

  class << self

    def included xy
      xy.instance_variable_set :@xyz, addZ(xy)
      xy.class_exec do
        define_method :xyz do
          xy.instance_variable_get :@xyz
        end
      end
      one_color_xlabel xy
    end

    def excluded xy
      colorful_xlabel xy
    end

    private
    
    def addZ xy      
      Class.new xy do
      
        define_method :initialize do |opts={}, &blk|
          @hash = opts[:base]
          @by = blk
          acceptStyle opts
        end
        
        private
        
        define_method :type do
          xy.to_s.downcase
        end
        
        define_method :labels do
          @hash.keys
        end
        
        define_method :datasets do
          labels_in_datasets = keys_in_sub_hash hash_2d
          labels_in_datasets.map do |lb|
            {
              label: lb,
              data: hash_2d.map{ |k, sub_hash| sub_hash[lb].count}
            }
          end
        end
        
        define_method :hash_2d do
          @hash_2d ||= Hash[@hash.map{ |label, objs| [label, objs.group_by(&@by)] }]
        end
        
        define_method :keys_in_sub_hash do |hash_2d|
          hash_2d.values.reduce([]) do |labels, hash|
            labels + hash.keys
          end.uniq
        end

      end
    end
    
    def one_color_xlabel xy
      xy.class_exec do
        private
        define_method :color do
          color = RGBA.new
          {
           borderColor: color.notation,
           backgroundColor: color.darker.notation
          }
        end
      end
    end

    def colorful_xlabel xy
      xy.class_exec do
        private
        define_method :color do
          colors = labels.map{ |l| RGBA.new }
          {
           borderColor: colors.map{ |c| c.notation },
           backgroundColor: colors.map{ |c| c.darker.notation }
          }
        end
      end
    end
  
  end

  def group_by opts={}, &blk
    raise 'already have z axis' if z_axis?
    xyz.new opts.merge({base: groups}), &blk
  end
  
  private
  
  def z_axis?
    groups.any? { |label, value| value.kind_of? Hash }
  end
end