class Api::V1::MerchantsController < ApplicationController
  def index
    # binding.pry
    # render json: Merchant.all 
    merchant = Merchant.all
    render json: MerchantSerializer.new(merchant)
  end
end 