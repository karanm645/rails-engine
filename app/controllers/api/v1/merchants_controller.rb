class Api::V1::MerchantsController < ApplicationController
  def index
    merchant = Merchant.all
    render json: MerchantSerializer.new(merchant)
  end
  
  def most_items
    number = params[:quantity]
    merchants = Merchant.top_merchant_count(number)
    render json: ::MerchantMostItemsSerializer.new(merchants)
  end 
  
  def show 
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end 

  def find 
    merchant = Merchant.find_merchant(params[:name])
    if merchant.nil?
      render json: { data: { message: 'Merchant not found'}}
    else 
      render json: MerchantSerializer.new(merchant)
    end 
  end 

end 