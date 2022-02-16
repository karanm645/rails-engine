class MerchantMostItemsSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :count do |object|
    object.total_count 
  end 
end