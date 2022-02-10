class Api::V1::MerchantsController < ApplicationController
  def index
    # binding.pry
    # render json: Merchant.all 
    merchant = Merchant.all
    render json: MerchantSerializer.new(merchant)
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