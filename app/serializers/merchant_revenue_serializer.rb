class MerchantRevenueSerializer
  include JSONAPI::Serializer
  set_id :id 
  
  attributes :revenue do |object|
    object.revenue 
  end 
end