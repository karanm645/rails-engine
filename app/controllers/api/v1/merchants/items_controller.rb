class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    item = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(item)

    # rescue ActiveRecord::RecordNotFound
    # render json: { message: "404" }
  end
end 