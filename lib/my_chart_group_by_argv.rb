module MyChart
  class Chart

    class GroupByARGV

      attr_reader :material_id, :production_id

      def initialize *args
        if material_specified? args
          @material_id = args[0]
          @production_id = concat_production_id @material_id, args[1][:by]
        elsif material_not_specified? args
          @material_id = ALL_DATA
          @production_id = [:GROUP, :BY, args[0][:by]].join('_').to_sym
        else
          raise "invalid arguments for group_by : #{args}"
        end
      end

      private

      def material_specified? args
        args.size == 2 and args[1].kind_of? Hash and args[1][:by]
      end

      def material_not_specified? args
        args.size == 1 and args[0].kind_of? Hash and args[0][:by]
      end

      def concat_production_id material, by
        string = if material =~ /^GROUP/
                   [material, :AND_THEN, :GROUP, :BY, by]
                 else
                   [:GROUP, material, :BY, by]
                 end
        string.join('_').to_sym
      end
    end

  end
end
