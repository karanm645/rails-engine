class MerchantSerializer
  include JSONAPI::Serializer
  set_type :merchant
  set_id :id 
  attributes :name, :id

  # has_many :items 
end
