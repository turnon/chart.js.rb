class XYZ
  def initialize objs_2d_hash
    @objs_2d_hash = objs_2d_hash
  end

  def value
    @objs_2d_hash
  end

  def labels
    value.keys
  end

  def datasets
    labels_in_datasets = keys_in_sub_hash value
    labels_in_datasets.map do |lb|
      {
        label: lb,
        data: value.map{ |k, sub_hash| sub_hash[lb] ? sub_hash[lb].count : 0}
      }
    end
  end

  def == obj
    obj.kind_of? XYZ and value == obj.value
  end

  private

  def keys_in_sub_hash hash_2d
    hash_2d.values.reduce([]) do |labels, hash|
      labels + hash.keys
    end.uniq.sort_by(&:to_s)
  end

end
