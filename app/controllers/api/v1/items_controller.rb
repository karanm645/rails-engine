class Api::V1::ItemsController < ApplicationController
  def index
    item = Item.all
    render json: ItemSerializer.new(item)
  end

  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end 

  def create 
    item = Item.new(item_params)
    item.save
    render json: ItemSerializer.new(item), status: 201
  end 

  def update 
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end 

  def destroy
    render json: Item.destroy(params[:id])
  end

  private 
  def item_params 
    params.permit(:name, :description, :unit_price, :merchant_id)
  end 
end 