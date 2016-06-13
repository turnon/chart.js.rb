require 'js'

class MultiDataChart

  include Js

  def initialize opts={}, &blk
    @hash = opts[:base]
    @by = blk
  end

  def labels
    @hash.keys
  end

  def datasets
    labels_in_datasets = keys_in_sub_hash hash_2d
    labels_in_datasets.map do |lb|
      {
        labels: lb,
        data: hash_2d.map{ |k, sub_hash| sub_hash[lb].count}
      }
    end
  end

  private

  def hash_2d
    @hash_2d ||= Hash[@hash.map{ |label, objs| [label, objs.group_by(&@by)] }]
  end

  def keys_in_sub_hash hash_2d
    hash_2d.values.reduce([]) do |labels, hash|
      labels + hash.keys
    end.uniq
  end
end