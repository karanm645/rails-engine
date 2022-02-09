class Api::V1::ItemsController < ApplicationController
  def index
    # binding.pry
    # render json: Merchant.all 
    item = Item.all
    render json: ItemSerializer.new(item)
  end

  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end 

end 