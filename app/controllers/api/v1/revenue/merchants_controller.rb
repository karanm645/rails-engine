class Api::V1::Revenue::MerchantsController < ApplicationController
  def index 
    # error message if nil
    number = params[:quantity]
    merchants = Merchant.top_merchants_by_revenue(number)
    render json: ::MerchantNameRevenueSerializer.new(merchants)
  end 

  def show 
    id = params[:id]
    merchants = Merchant.single_merchant_revenue(id)
    render json: ::MerchantRevenueSerializer.new(merchants)
  end 
end 