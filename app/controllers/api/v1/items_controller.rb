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
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else 
      render status: 404
    end 
  end 

  def destroy
    render json: Item.destroy(params[:id])
  end

  def find_all
    items = Item.find_items(params[:name])
    if items.nil?
      render json: { data: { message: 'Items not found'}}
    else 
      render json: ItemSerializer.new(items)
    end 
  end 

  private 
  def item_params 
    params.permit(:name, :description, :unit_price, :merchant_id)
  end 
end 