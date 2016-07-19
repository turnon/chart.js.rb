module MyChart
  class Chart

    class SelectFromARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if args.size == 2 and args[1].kind_of? Hash and args[1][:from]
          @material_id = args[1][:from]
          @production_id = [args[0], :FROM, material_id].join('_').to_sym
        elsif args.size == 1
          @material_id = ALL_DATA
          @production_id = args[0]
        else
          raise "invalid arguments for select : #{args}"
        end
      end
    end

  end
end
