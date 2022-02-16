class Api::V1::Revenue::ItemsController < ApplicationController
  def index 
    # if the quantity is defined 
    number = params[:quantity]
    items = Item.item_with_most_revenue(number)
    render json: ::ItemQuantitySerializer.new(items)
  end 
end 