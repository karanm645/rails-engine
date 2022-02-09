require 'rails_helper'

RSpec.describe 'items merchant exposure' do 
  
  describe 'happy path' do 
    it "can get a items merchant" do 
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      # id = create(:merchant).id
      get "/api/v1/items/#{item.id}/merchant"
      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
    
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end 
  end 
  describe 'sad path' do 
    it 'cant find a merchant' do 
      id = 0
      get "/api/v1/items/#{id}/merchant"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
    end 
  end 
end 